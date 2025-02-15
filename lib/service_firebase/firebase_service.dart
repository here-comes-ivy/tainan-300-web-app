import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class FirebaseService extends ChangeNotifier {
  List<Map<String, dynamic>>? _cachedData;
  DateTime? _lastFetchTime;
  static const cacheDuration = Duration(minutes: 5);

  Future<List<Map<String, dynamic>>> getAllLandmarkDataFromFirestore() async {
    // 檢查記憶體中的快取是否仍然有效
    if (_cachedData != null && _lastFetchTime != null) {
      final now = DateTime.now();
      if (now.difference(_lastFetchTime!) < cacheDuration) {
        return _cachedData!;
      }
    }

    try {
      final QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('landmarks').get();

      _cachedData = querySnapshot.docs
          .where((doc) => doc.id != 'metadata')
          .map((doc) => {
                'id': doc.id,
                ...doc.data() as Map<String, dynamic>,
              })
          .toList();
      
      _lastFetchTime = DateTime.now();
      return _cachedData!;
    } catch (e) {
      print('Error getting locations from Firestore: $e');
      return _cachedData ?? [];
    }
  }

  void clearCache() {
    _cachedData = null;
    _lastFetchTime = null;
  }
}
