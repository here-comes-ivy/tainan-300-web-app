import 'package:explore_tainan_web/service_liff/globalLiffData.dart';
import 'package:flutter/material.dart';

class LandmarkdetailsCard extends StatelessWidget {
  const LandmarkdetailsCard({super.key});

  @override
  Widget build(BuildContext context) {
    String landmarkInfoTitle =
        GlobalLiffData.landmarkInfoTitle ?? 'Landmark Info Title';
    String landmarkInfoDescription =
        GlobalLiffData.landmarkInfoDescription ?? 'Landmark Info Description';
    String landmarkPictureUrl = GlobalLiffData.landmarkPictureUrl ?? '';

    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            landmarkPictureUrl.isNotEmpty
                ? Image.network(landmarkPictureUrl)
                : Image.asset('assets/images/iF300eventMap.jpg'),
            SizedBox(height: 5),

            Text(
              landmarkInfoTitle,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(landmarkInfoDescription),
          ],
        ),
      ),
    );
  }
}
