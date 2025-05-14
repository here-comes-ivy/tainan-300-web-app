import '../services/firestoreService2.dart';
// import '../services/firestoreService.dart';

import 'package:web/web.dart' as web;

class LandmarkData {
  static bool isSendMessage = false;
  static String? locationSegment;
  static List<Map<String, dynamic>> allLandmarkDetails = [];
  static Map<String, dynamic> landmarkDetails = {};
  static String? landmarkName;
  static String? password;
  static String? landmarkPictureUrl;
  static String? landmarkDescription;

  static bool isLandmarkPageShown = false;
    bool isInitialized = false;


  FirestoreService firestoreService = FirestoreService();

  static Future<void> showLandmarkMessage() async {
    isLandmarkPageShown = landmarkDetails.isNotEmpty;
  }

static void _processLandmarkDetails(Map<String, dynamic> details) {
  landmarkDetails = Map<String, dynamic>.from(details);
    landmarkName = details['landmark_name'];
  password = details['password'];
  landmarkPictureUrl = details['landmark_pictureUrl'].toString();
  landmarkDescription = details['landmark_description'];

}

  Future<void> getDataFromFirestore() async {
  try {
    await getParameters();

    if (locationSegment != null && locationSegment!.isNotEmpty) {
      final data = await firestoreService.getLandmarkById(locationSegment!);
      if (data != null) {
        _processLandmarkDetails(data);
        showLandmarkMessage();
      } 
    } 

    isInitialized = true;
  } catch (e) {
    isInitialized = true;
  }
}

  static Future<void> getParameters() async {
    try {
      final uri = Uri.parse(web.window.location.href);
      // 取得 pathSegments
      final pathSegments = uri.pathSegments;
      if (pathSegments.isNotEmpty) {
        locationSegment = pathSegments.last; // 取得最後一段 path
      } else {
        locationSegment = null;
        landmarkName = 'Default Location';
      }
      final sendMessageParam = uri.queryParameters['sendMessage'];
      isSendMessage = sendMessageParam?.toLowerCase() == 'true';
    } catch (e) {
      locationSegment = null;
    }
  }

}
