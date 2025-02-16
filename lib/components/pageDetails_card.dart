import 'package:flutter/material.dart';
import 'package:explore_tainan_web/service_liff/globalLiffData.dart';
import 'landmark_message.dart';
import 'welcome_message.dart';

class LandmarkdetailsCard extends StatelessWidget {
  const LandmarkdetailsCard({super.key});

  @override
  Widget build(BuildContext context) {

    return Card(
      color: Colors.white,
      elevation: 4,
       shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      child: Padding(
        padding:
            const EdgeInsets.only(top: 37, left: 20, right: 20, bottom: 12),
        child: (GlobalLiffData.isLandmarkPageShown)
                  ? LandmarkMessage()
                  : WelcomingMessage(),
      ),
    );
  }
}
