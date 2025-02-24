// 引入版本文件
importScripts('version.js');

const CACHE_NAME = `flutter-app-${APP_VERSION}`;
const RESOURCES = [
  './index.html',
  './version.js',
  './flutter_bootstrap.js?version=' + APP_VERSION,
  './flutter.js',
  './favicon.ico',
  './icons/Icon-192.png',
  './icons/Icon-512.png',
  './manifest.json',
  './assets/fonts/',
  './assets/images/',
  './assets/animations/',
];

// 安装事件 - 缓存资源
// 在service-worker.js中修改fetch事件处理程序
self.addEventListener('fetch', (event) => {
    // 检查是否是外部资源（如Line SDK）
    if (event.request.url.includes('line-scdn.net') || 
        event.request.url.includes('cdn') || 
        !event.request.url.startsWith(self.location.origin)) {
      // 对外部资源使用网络优先策略，不进行缓存干预
      event.respondWith(fetch(event.request));
      return;
    }
    
    // 对应用自身资源使用缓存优先策略
    event.respondWith(
      caches.match(event.request).then((response) => {
        if (response) {
          return response;
        }
        return fetch(event.request).then((response) => {
          if (!response || response.status !== 200 || response.type !== 'basic') {
            return response;
          }
          var responseToCache = response.clone();
          caches.open(CACHE_NAME).then((cache) => {
            cache.put(event.request, responseToCache);
          });
          return response;
        });
      })
    );
  });

// 激活事件 - 清理旧缓存
self.addEventListener('activate', (event) => {
  console.log('Service Worker啟動中...');
  event.waitUntil(
    caches.keys().then((keyList) => {
      return Promise.all(keyList.map((key) => {
        if (key !== CACHE_NAME) {
          console.log('刪除舊緩存:', key);
          return caches.delete(key);
        }
      }));
    }).then(() => {
      console.log('现在使用缓存:', CACHE_NAME);
      return self.clients.claim(); // 接管所有客户端
    })
  );
});

// 请求拦截
self.addEventListener('fetch', (event) => {
  event.respondWith(
    caches.match(event.request).then((response) => {
      if (response) {
        return response; // 如果缓存中有，直接返回缓存
      }
      
      // 否则请求网络
      return fetch(event.request).then((response) => {
        // 检查是否有效
        if (!response || response.status !== 200 || response.type !== 'basic') {
          return response;
        }
        
        // 克隆响应（因为响应流只能使用一次）
        var responseToCache = response.clone();
        
        // 缓存新资源
        caches.open(CACHE_NAME).then((cache) => {
          cache.put(event.request, responseToCache);
        });
        
        return response;
      });
    })
  );
});