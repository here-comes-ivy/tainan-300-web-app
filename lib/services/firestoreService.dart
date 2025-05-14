import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class FirestoreService extends ChangeNotifier {
  final Map<String, Map<String, dynamic>> _landmarksCache = {};
  final Map<String, DateTime> _landmarksCacheTimestamp = {}; 
  final Duration cacheExpiryDuration = Duration(hours: 72);

  Future<Map<String, dynamic>?> getLandmarkById(String landmarkId,
      {bool preload = false}) async {
    // 先檢查快取
    bool shouldFetch = _shouldFetchFromFirestore(landmarkId);

    if (!shouldFetch && _landmarksCache.containsKey(landmarkId)) {
      return _landmarksCache[landmarkId];
    }

      final docSnapshot = await FirebaseFirestore.instance
          .collection('landmarks')
          .doc(landmarkId)
          .get();

      if (!docSnapshot.exists) {
        return null;
      }

      final data = docSnapshot.data() as Map<String, dynamic>;
      data['uid'] = docSnapshot.id;

      _landmarksCache[landmarkId] = data;
      _landmarksCacheTimestamp[landmarkId] = DateTime.now();

      return data;

  }

  bool _shouldFetchFromFirestore(String landmarkId) {
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
