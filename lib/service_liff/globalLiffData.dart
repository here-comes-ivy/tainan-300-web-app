import 'package:flutter/material.dart';
import 'package:flutter_line_liff/flutter_line_liff.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../service_firebase/firebase_service.dart';
import 'dart:html' as html;
import 'package:flutter/foundation.dart' show kIsWeb;

class GlobalLiffData {
  static final FlutterLineLiff liffInstance = FlutterLineLiff();
  static bool isLoggedIn = false;
  static bool isInitialized = false;

  static Uri? uri;
  static String? userId;

  static String? language;
  static String? lineVersion;
  static String? context;

  static String? decodedIDToken;
  static String? accessToken;
  static String? idToken;
  static bool? isInclient;
  static bool? isSendMessage;

  static String? userName;
  static String? userPhotoUrl;

  static bool? friendshipStatus;

  static List<Map<String, dynamic>> allLandmarkDetails = [];
  static Map<String, dynamic> landmarkDetails = {};
  static String? landmarkName;
  static String password = '未知密碼';
  static LatLng? landmarkLatLng;
  static String? landmarkPictureUrl;
  static String? landmarkInfoTitle;
  static String? landmarkInfoDescription;

  static Future<void> getAllLiffData() async {
    print("Starting data initialization...");
    try {
      await Future.wait([
        getAllLandmarkFromFirestore(),
        getLiffData(),
        getProfileData(),
        getFriendshipData(),
      ]);
      await getSelectedLandmarkData();
      isInitialized = true;
    } catch (e) {
      isInitialized = false;
      print("Error initializing LIFF data: $e");
    }
  }

  static Future<void> getLiffData() async {
    if (kIsWeb && !isInitialized) {
      await Future.microtask(() {
        userId = liffInstance.context?.userId;
        language = liffInstance.language;
        lineVersion = liffInstance.lineVersion;
        context = liffInstance.context?.toDebugString();
        decodedIDToken = liffInstance.getDecodedIDToken()?.toDebugString();
        accessToken = liffInstance.getAccessToken();
        idToken = liffInstance.getIDToken();
        isInclient = liffInstance.isInClient;
      });
    } else {}
  }

  static Future<void> getProfileData() async {
    try {
      if (!isInitialized) {
        final profileData = await liffInstance.profile;
        userName = profileData.displayName;
        userId = profileData.userId;
        userPhotoUrl = profileData.pictureUrl;
      }
    } catch (e) {
      print('Error getting profile data: $e');
    }
  }

  static Future<void> getFriendshipData() async {
    try {
      if (!isInitialized) {
        final friendshipData = await liffInstance.friendship;
        friendshipStatus = friendshipData.friendFlag;
      }
    } catch (e) {
      print('Error getting friendship status: $e');
    }
  }

  static Future<void> getLocationDataFromUrl() async {
    try {
      if (!isInitialized) {
        final uri = Uri.parse(html.window.location.href);

        // 取得 landmark uid
        final pathSegments = uri.pathSegments;
        print('pathSegments: $pathSegments');

        if (pathSegments.isNotEmpty) {
          landmarkName = pathSegments.last; // 取得最後一段 path
        } else {
          landmarkName = 'Url location';
        }

        // 取得 sendMessage 參數
        final sendMessageParam = uri.queryParameters['sendMessage'];
        isSendMessage = sendMessageParam?.toLowerCase() == 'true';

        print('Landmark Name: $landmarkName');
        print('Should Send Message: $isSendMessage');
      }
    } catch (e) {
      print('Error getting location data from Url: $e');
    }
  }

  static Future<void> getAllLandmarkFromFirestore() async {
    try {
      final firebaseService = FirebaseService();
      allLandmarkDetails =
          await firebaseService.getAllLandmarkDataFromFirestore();
    } catch (e) {
      print('Error getting all landmark data from Firestore: $e');
    }
  }

  static Future<void> getSelectedLandmarkData() async {
    try {
      final uri = Uri.parse(html.window.location.href);
      String locationParam = uri.queryParameters['uid'] ?? '';

      if (locationParam.isNotEmpty) {
        landmarkDetails = allLandmarkDetails.firstWhere(
          (landmark) => landmark['id'] == locationParam,
          orElse: () => <String, dynamic>{},
        );
        if (allLandmarkDetails.isNotEmpty) {
          landmarkName = landmarkDetails['landmark_name'];
          password = landmarkDetails['password'];

          landmarkLatLng = LatLng(
            landmarkDetails['position_lat'] as double,
            landmarkDetails['position_lng'] as double,
          );
          landmarkPictureUrl =
              landmarkDetails['landmark_pictureUrl'].toString();
          landmarkInfoTitle = landmarkDetails['infoWindow_title'];
          landmarkInfoDescription = landmarkDetails['infoWindow_snippet'];
        } else {
          await getLocationDataFromUrl();
        }
      } else {
        await getLocationDataFromUrl();
      }
    } catch (e) {
      print('Error getting the selected location data: $e');
      await getLocationDataFromUrl();
    }
  }
}
