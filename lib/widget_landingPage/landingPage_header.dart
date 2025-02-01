import 'package:explore_tainan_web/service_liff/globalLiffData.dart';
import 'package:flutter/material.dart';

class LandingPageHeader extends StatefulWidget {
 LandingPageHeader({Key? key}) : super(key: key);

  @override
  State<LandingPageHeader> createState() => _LandingPageHeaderState();
}

class _LandingPageHeaderState extends State<LandingPageHeader> {
  @override
  Widget build(BuildContext context) {

    String? pictureUrl = GlobalLiffData.userPhotoUrl;

    return SizedBox(
      height: 50,
      child: Row(
        children: [
            Align(
            alignment: Alignment.centerLeft,
            child: CircleAvatar(
              foregroundImage: 
              pictureUrl != null ? NetworkImage(pictureUrl) : AssetImage('assets/images/defaultProfilePic.png'),
            ),
            ),
          Expanded(
            child: Container(
                margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                decoration: BoxDecoration(
                  color: Color(0xFFCBAA39),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Tainan 300 Demo',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
