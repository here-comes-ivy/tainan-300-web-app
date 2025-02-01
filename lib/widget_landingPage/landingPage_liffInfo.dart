import '../service_liff/globalLiffData.dart';
import 'package:flutter/material.dart';
import '../service_liff/liffProfileData.dart';

class LiffInfo extends StatelessWidget {
  LiffInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String location = GlobalLiffData.landmarkName ?? 'Not available';
    String password = GlobalLiffData.password ?? 'Not available';

    String userId = GlobalLiffData.userId ?? 'Not available';
    String lineVersion = GlobalLiffData.lineVersion ?? 'Not available';
    String context = GlobalLiffData.context ?? 'Not available';
    String language = GlobalLiffData.language ?? 'Not available';
    String decodedIDToken = GlobalLiffData.decodedIDToken ?? 'Not available';

    String userName = GlobalLiffData.userName ?? 'User1';
    String? userPictureUrl = GlobalLiffData.userPhotoUrl;

    String firestoreLocation =
        GlobalLiffData.landmarkName ?? 'Firestore location unavailable';
    String firestorePassword =
        GlobalLiffData.password ?? 'Firestore password unavailable';
    String landmarkInfoTitle =
        GlobalLiffData.landmarkInfoTitle ?? 'Location Info Title';
    String landmarkInfoDescription =
        GlobalLiffData.landmarkInfoDescription ?? 'Location Info Description';
    String landmarkPictureUrl =
        GlobalLiffData.landmarkPictureUrl ?? 'Location Picture';
        String allLandmarkDetails = GlobalLiffData.allLandmarkDetails.toString();
        String landmarkDetails = GlobalLiffData.landmarkDetails.toString();

    return Column(
      children: [
        // LiffProfileData(),
        CircleAvatar(
          foregroundImage:
              userPictureUrl != null ? NetworkImage(userPictureUrl) : null,
        ),
        CircleAvatar(
          foregroundImage:
              userPictureUrl != null ? NetworkImage(landmarkPictureUrl) : null,
        ),
        Text(
          'Firestore All Landmark Details: $allLandmarkDetails\n\n'
          'Firestore Landmark Details: $landmarkDetails\n\n'
          'Firestore Location: $firestoreLocation\n\n'
            'Firestore Password: $firestorePassword\n\n'
            'Firestore Location Info Title: $landmarkInfoTitle\n\n'
            'Firestore Location Info Description: $landmarkInfoDescription\n\n'
            'Firestore Location Picture: $landmarkPictureUrl\n\n'
            'User ID: $userId\n\n'
            'User Name: $userName\n\n'
            'Location: $location \n\n'
            'Password: $password \n\n'
            'Language: $language\n\n'
            'LINE Version: $lineVersion\n\n'
            //'Profile: $profile\n\n'

            'DecodedIDToken: $decodedIDToken \n\n'
            'Context: $context\n\n'
            // 'Is in Client: ${liff.isInClient}\n\n'
            // 'Is Logged In: ${liff.isLoggedIn}\n\n'
            // 'Is API Available: ${liff.isApiAvailable(apiName: 'shareTargetPicker')}\n\n'
            // 'Access Token: ${liff.getAccessToken()}\n\n'
            // 'ID Token: ${liff.getIDToken()}\n\n'
            // 'Decoded ID Token: ${liff.getDecodedIDToken()?.toDebugString()}\n\n',
            ),
      ],
    );
  }
}
