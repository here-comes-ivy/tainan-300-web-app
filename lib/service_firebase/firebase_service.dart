import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';



class FirebaseService extends ChangeNotifier {
  static const String cacheKey = 'landmarks_cache';
  static const String lastFetchKey = 'landmarks_last_fetch';
  static const cacheDuration = Duration(minutes: 5);

  Future<List<Map<String, dynamic>>> getAllLandmarkDataFromFirestore() async {
    try {
      // 嘗試從 SharedPreferences 讀取
      try {
        final prefs = await SharedPreferences.getInstance();
        final lastFetchString = prefs.getString(lastFetchKey);
        final cacheString = prefs.getString(cacheKey);
        
        if (lastFetchString != null && cacheString != null) {
          final lastFetch = DateTime.parse(lastFetchString);
          if (DateTime.now().difference(lastFetch) < cacheDuration) {
            final List<dynamic> decoded = jsonDecode(cacheString);
            final List<Map<String, dynamic>> cachedData = 
                decoded.map((item) => Map<String, dynamic>.from(item)).toList();
            print('從 SharedPreferences 讀取快取數據');
            return cachedData;
          }
        }
      } catch (e) {
        print('讀取快取失敗：$e');
        // 快取讀取失敗，繼續從 Firestore 讀取
      }
      
      // 從 Firestore 讀取
      final QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('landmarks').get();
      
      List<Map<String, dynamic>> allLocations = [];
      for (var doc in querySnapshot.docs) {
        if (doc.id != 'metadata') {
          try {
            Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
            data['id'] = doc.id;
            allLocations.add(data);
          } catch (e) {
            print('Document parsing error for ${doc.id}: $e');
            continue;
          }
        }
      }
      
      // 嘗試寫入 SharedPreferences
      try {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(cacheKey, jsonEncode(allLocations));
        await prefs.setString(lastFetchKey, DateTime.now().toIso8601String());
        print('已將數據寫入 SharedPreferences');
      } catch (e) {
        print('寫入快取失敗：$e');
        // 快取寫入失敗，但仍返回數據
      }
      
      return allLocations;
    } catch (e) {
      print('Error getting locations from Firestore: $e');
      return [];
    }
  }
  
  Future<void> clearCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(cacheKey);
      await prefs.remove(lastFetchKey);
      print('快取已清除');
    } catch (e) {
      print('清除快取失敗：$e');
    }
  }
}
