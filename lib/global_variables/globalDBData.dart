import '../service_firebase/firebase_service.dart';
import 'dart:html' as html;
import 'globalLiffData.dart';

class GlobalDBData {
  static bool isSendMessage = false;

  static List<Map<String, dynamic>> allLandmarkDetails = [];
  static Map<String, dynamic> landmarkDetails = {};
  static String? landmarkName;
  static String? password;
  static String? landmarkPictureUrl;
  static String? landmarkInfoTitle;
  static String? landmarkInfoDescription;

  static bool isLandmarkPageShown = false;

  static Future<void> getAllDBData() async {
    print("Starting Firestore data initialization...");
    try {
      await Future.wait([
        getAllLandmarkFromFirestore(),
      
      ]);
      print("Executing getAllLandmarkFromFirestore...");
      await Future.wait([
        getSelectedLandmarkData(),
        //showLandmarkMessage()
      ]);
      print("Executing getSelectedLandmarkData...");

    } catch (e) {
      print("Error initializing Firestore data: $e");
    }
  }

  static Future<void> showLandmarkMessage() async {
    isLandmarkPageShown = (GlobalLiffData.friendshipStatus && landmarkDetails.isNotEmpty);
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
        String? locationSegment;
        // 取得 landmark uid
        final pathSegments = uri.pathSegments;
        print('pathSegments: $pathSegments');

        if (pathSegments.isNotEmpty) {
          locationSegment = pathSegments.last; // 取得最後一段 path
        } else {
          landmarkName = 'Url location';
        }
        final sendMessageParam = uri.queryParameters['sendMessage'];
        isSendMessage = sendMessageParam?.toLowerCase() == 'true';

        print('locationSegment: $locationSegment');
        print('Should Send Message: $isSendMessage');

        if (locationSegment != null && locationSegment.isNotEmpty) {
          landmarkDetails = allLandmarkDetails.firstWhere(
            (landmark) => landmark['id'] == locationSegment,
            orElse: () => <String, dynamic>{},
          );
          if (allLandmarkDetails.isNotEmpty) {
            landmarkName = landmarkDetails['landmark_name'];
            password = landmarkDetails['password'];

            landmarkPictureUrl =
                landmarkDetails['landmark_pictureUrl'].toString();
            landmarkInfoTitle = landmarkDetails['infoWindow_title'];
            landmarkInfoDescription = landmarkDetails['infoWindow_snippet'];

            print('Selected Landmark Details: $landmarkDetails');
          } else {
            // await getLocationDataFromUrl();
          }
        }
    } catch (e) {
      print('Error getting the selected location data: $e');
      // await getLocationDataFromUrl();
    }
  }
}
