import 'dart:html' as html;
import 'package:explore_tainan_web/service_liff/globalLiffData.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:js/js.dart';

class LineLiffState {
  String? userId;
  String? displayName;


  Future<void> _saveToFirestore(String userId, String displayName) async {
    final db = FirebaseFirestore.instance;
    await db.collection('users').doc(userId).set({
      'userId': userId,
      'displayName': displayName,
      'visitedAt': DateTime.now().toIso8601String(),
    });
    print("User saved to Firestore: $userId");
  }

  Future<void> countVisit() async {
    try {
      print('Attempting to count visit...');
      await FirebaseFirestore.instance.collection('visit').doc('count').set({
        'count': FieldValue.increment(1),
        'lastVisit': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
      print('Visit counted successfully');
    } catch (e) {
      print('Error counting visit: $e');
    }
  }

  Future<void> addUserToFirebase(String userId, String displayName) async {
    try {
      print(
          'Attempting to add user to Firebase - ID: $userId, Name: $displayName');

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .set(<String, dynamic>{
        'displayName': displayName,
        'lastVisit': FieldValue.serverTimestamp(),
        'createdAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      print('Successfully added user to Firebase');
    } catch (e) {
      print('Error adding user to Firebase: $e');
      throw Exception('Failed to add user to Firebase: $e');
    }
  }

}
