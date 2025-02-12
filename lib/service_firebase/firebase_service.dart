import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';

class FirebaseService extends ChangeNotifier {
  static const String cacheKey = 'landmarks_cache';
  static const String lastFetchKey = 'landmarks_last_fetch';

  /// 取得所有地標資料（根據 Firestore `lastUpdated` 決定是否更新快取）
  Future<List<Map<String, dynamic>>> getAllLandmarkDataFromFirestore() async {
    print('Starting getLocationDataFromFirestore for all landmarks');

    try {
      final prefs = await SharedPreferences.getInstance();

      // 1. 取得 Firestore 最新的 `lastUpdated`
      final Timestamp? firestoreLastUpdated = await _getFirestoreLastUpdated();

      if (firestoreLastUpdated == null) {
        print('Failed to fetch Firestore lastUpdated timestamp');
        return [];
      }

      // 2. 取得快取的 `lastFetchTime`
      final int? lastFetchTime = prefs.getInt(lastFetchKey);

      if (lastFetchTime != null) {
        DateTime lastFetchDateTime =
            DateTime.fromMillisecondsSinceEpoch(lastFetchTime);
        DateTime firestoreUpdatedTime = firestoreLastUpdated.toDate();

        print('Firestore lastUpdated: $firestoreUpdatedTime');
        print('Local cache lastFetchTime: $lastFetchDateTime');

        // 如果快取時間比 Firestore `lastUpdated` 晚，則使用快取
        if (lastFetchDateTime.isAfter(firestoreUpdatedTime)) {
          print('Cache is up-to-date, loading from cache.');
          final cachedData = await _getCachedLandmarks();
          if (cachedData.isNotEmpty) return cachedData;
        } else {
          print('Cache outdated, fetching new data from Firestore.');
        }
      } else {
        print('No previous fetch record, fetching from Firestore.');
      }

      // 3. 從 Firestore 讀取新資料
      final QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('landmarks').get();

      List<Map<String, dynamic>> allLocations = querySnapshot.docs
          .where((doc) => doc.id != 'metadata') // 🔹 這行會排除 "metadata" document
          .map((doc) => {
                'id': doc.id,
                ...doc.data() as Map<String, dynamic>,
              })
          .toList();

      // 4. 更新快取與 `lastFetchTime`
      await _cacheLandmarks(allLocations, firestoreLastUpdated);

      print('Successfully retrieved all locations from Firestore');
      return allLocations;
    } catch (e, stackTrace) {
      print('Error getting locations from Firestore: $e');
      print('Stack trace: $stackTrace');
      return [];
    }
  }

  /// 取得 Firestore 中 `lastUpdated` 時間戳
  Future<Timestamp?> _getFirestoreLastUpdated() async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('landmarks')
          .doc('metadata')
          .get();

      if (snapshot.exists && snapshot.data() != null) {
        return snapshot['lastUpdated'] as Timestamp?;
      }
      return null;
    } catch (e) {
      print('Error fetching lastUpdated timestamp: $e');
      return null;
    }
  }

  /// 取得快取的地標資料
  Future<List<Map<String, dynamic>>> _getCachedLandmarks() async {
    final prefs = await SharedPreferences.getInstance();
    final String? jsonString = prefs.getString(cacheKey);

    if (jsonString != null) {
      final List<dynamic> jsonData = json.decode(jsonString);
      return jsonData.cast<Map<String, dynamic>>();
    }
    return [];
  }

  /// 儲存快取並更新 `lastFetchTime`
  Future<void> _cacheLandmarks(
      List<Map<String, dynamic>> landmarks, Timestamp lastUpdated) async {
    final prefs = await SharedPreferences.getInstance();
    final String jsonString = json.encode(landmarks);
    await prefs.setString(cacheKey, jsonString);
    await prefs.setInt(
        lastFetchKey, lastUpdated.toDate().millisecondsSinceEpoch);
    print('Landmarks cached successfully with lastUpdated timestamp');
  }

  /// 手動清除快取
  Future<void> clearCache() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(cacheKey);
    await prefs.remove(lastFetchKey);
    print('Cache cleared');
  }
}
