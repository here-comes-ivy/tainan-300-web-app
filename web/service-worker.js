// 引入版本文件
importScripts('version.js');

const CACHE_NAME = `flutter-app-${APP_VERSION}`;
const RESOURCES = [
  './index.html',
  './version.js',
  './main.dart.js?version=' + APP_VERSION,
  './flutter.js',
  './favicon.png',
  './icons/Icon-192.png',
  './icons/Icon-512.png',
  './manifest.json',
  './assets/fonts/',
  './assets/images/',
  './assets/animations/',
];

// 安装事件 - 缓存资源
self.addEventListener('install', (event) => {
  event.waitUntil(
    caches.open(CACHE_NAME).then((cache) => {
      console.log('Cache opened, adding resources');
      return cache.addAll(RESOURCES);
    }).then(() => {
      console.log('New version of Service Worker loaded');
      return self.skipWaiting(); 
    })
  );
});

// 激活事件 - 清理旧缓存
self.addEventListener('activate', (event) => {
  console.log('Service Worker activated...');
  event.waitUntil(
    caches.keys().then((keyList) => {
      return Promise.all(keyList.map((key) => {
        if (key !== CACHE_NAME) {
          console.log('Deleting old cache:', key);
          return caches.delete(key);
        }
      }));
    }).then(() => {
      console.log('Now using cache:', CACHE_NAME);
      return self.clients.claim(); 
    })
  );
});

// 请求拦截
self.addEventListener('fetch', (event) => {
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