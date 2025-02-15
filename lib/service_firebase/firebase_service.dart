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
      return allLocations;
    } catch (e) {
      print('Error getting locations from Firestore: $e');
      return [];
    }
  }

  void clearCache() {
    _cachedData = null;
    _lastFetchTime = null;
  }
}
