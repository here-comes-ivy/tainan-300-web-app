import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FirestoreService extends ChangeNotifier {
  // 保留本地快取作為第一層
  final Map<String, Map<String, dynamic>> _landmarksCache = {};
  final Map<String, DateTime> _landmarksCacheTimestamp = {}; 
  final Duration cacheExpiryDuration = Duration(hours: 6); // 本地快取時間可以縮短
  
  // Cloud Run 服務的 URL
  final String baseUrl = 'https://tainan300-firestore-cache-844416870696.asia-east1.run.app';

  Future<Map<String, dynamic>?> getLandmarkById(String landmarkId) async {
    // 先檢查本地快取
    bool shouldFetch = _shouldFetchFromServer(landmarkId);

    if (!shouldFetch && _landmarksCache.containsKey(landmarkId)) {
      return _landmarksCache[landmarkId];
    }

    try {
      // 使用 HTTP 請求調用 Cloud Run API
      final response = await http.get(
        Uri.parse('$baseUrl/api/landmarks/$landmarkId'),
        headers: await _getAuthHeaders(), // 添加認證頭
      );
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        
        // 更新本地快取
        _landmarksCache[landmarkId] = data;
        _landmarksCacheTimestamp[landmarkId] = DateTime.now();
        
        return data;
      } else if (response.statusCode == 404) {
        return null;
      } else {
        print('Error status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to load landmark');
      }
    } catch (e) {
      print('Error fetching landmark: $e');
      return null;
    }
  }
  
  // 批量獲取地標方法
  Future<Map<String, Map<String, dynamic>>> getLandmarksByIds(List<String> ids) async {
    final Map<String, Map<String, dynamic>> results = {};
    final List<String> idsToFetch = [];
    
    // 檢查本地快取
    for (final id in ids) {
      if (!_shouldFetchFromServer(id) && _landmarksCache.containsKey(id)) {
        results[id] = _landmarksCache[id]!;
      } else {
        idsToFetch.add(id);
      }
    }
    
    if (idsToFetch.isEmpty) {
      return results;
    }
    
    try {
      // 調用批量 API
      final response = await http.post(
        Uri.parse('$baseUrl/api/landmarks/batch'),
        headers: {
          'Content-Type': 'application/json',
          ...(await _getAuthHeaders()),
        },
        body: json.encode({'ids': idsToFetch}),
      );
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        
        // 更新本地快取
        data.forEach((id, value) {
          final landmarkData = Map<String, dynamic>.from(value);
          results[id] = landmarkData;
          _landmarksCache[id] = landmarkData;
          _landmarksCacheTimestamp[id] = DateTime.now();
        });
        
        return results;
      } else {
        print('Error status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to batch load landmarks');
      }
    } catch (e) {
      print('Error batch fetching landmarks: $e');
      throw e;
    }
  }
  
  // 獲取認證頭部
  Future<Map<String, String>> _getAuthHeaders() async {
    // 如果您的 Cloud Run 服務需要身份驗證
    // 這裡可以返回空 Map 如果您的服務設置為允許未認證訪問
    return {};
    
    // 如果需要認證，您可以使用 Firebase Auth
    /*
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final token = await user.getIdToken();
        return {
          'Authorization': 'Bearer $token',
        };
      }
    } catch (e) {
      print('Error getting auth token: $e');
    }
    return {};
    */
  }

  bool _shouldFetchFromServer(String landmarkId) {
    if (!_landmarksCache.containsKey(landmarkId)) {
      return true; 
    }

    final cacheTime = _landmarksCacheTimestamp[landmarkId];
    if (cacheTime == null) {
      return true; 
    }

    final now = DateTime.now();
    final durationSinceCache = now.difference(cacheTime);

    if (durationSinceCache > cacheExpiryDuration) {
      return true; 
    }

    return false; 
  }
}