import 'package:flutter/material.dart';
import '../constants/landmarkData.dart';
import 'landmark_message.dart';
import 'welcome_message.dart';
import 'redirect_button.dart';

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

        child: Column(
          children: [
            (LandmarkData.isLandmarkPageShown)
                      ? LandmarkMessage()
                      : WelcomingMessage(),
            const SizedBox(height: 12),
           
          ],
        ),
      ),
    );
  }
}
