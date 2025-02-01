import 'package:cloud_firestore/cloud_firestore.dart'; // new
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:flutter_line_liff/flutter_line_liff.dart';

class FirebaseService extends ChangeNotifier {

 Future<List<Map<String, dynamic>>> getAllLandmarkDataFromFirestore() async {
  print('Starting getLocationDataFromFirestore for all landmarks');
  
  try {
    print('Attempting to connect to Firestore...');
    
    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('landmarks')
        .get();
    
    print('Query completed. Documents count: ${querySnapshot.docs.length}');
    
    List<Map<String, dynamic>> allLocations = querySnapshot.docs.map((doc) {
      return {
        'id': doc.id,
        ...doc.data() as Map<String, dynamic>,
      };
    }).toList();
    
    if (allLocations.isEmpty) {
      return [];
    } else {
      print('Successfully retrieved all locations from Firestore');
      return allLocations;
    }
    
  } catch (e, stackTrace) {
    print('Error getting locations from Firestore: $e');
    print('Stack trace: $stackTrace');
    return [];
  }
}
  
}
