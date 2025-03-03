import 'package:flutter_line_liff/flutter_line_liff.dart';
import 'dart:html' as html;
import 'package:flutter/foundation.dart' show kIsWeb;

class GlobalLiffData {
  static final FlutterLineLiff liffInstance = FlutterLineLiff.instance;
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
  static bool isSendMessage = false;

  static String? userName;
  static String? userPhotoUrl;

  static bool friendshipStatus = false;

  static List<Map<String, dynamic>> allLandmarkDetails = [];
  static Map<String, dynamic> landmarkDetails = {};
  static String? landmarkName;
  static String? password;
  static String? landmarkPictureUrl;
  static String? landmarkInfoTitle;
  static String? landmarkInfoDescription;


  static Future<void> getAllLiffData() async {
    print("Starting Liff data initialization...");
    try {
      await Future.wait([
        getLiffData(),
        getProfileData(),
        getFriendshipData(),
      ]);
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
        language = liffInstance.appLanguage;
        lineVersion = liffInstance.lineVersion;
        context = liffInstance.context?.toString();
        decodedIDToken = liffInstance.getDecodedIDToken()?.toString();
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

}
