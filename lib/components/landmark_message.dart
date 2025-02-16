import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:explore_tainan_web/service_liff/globalLiffData.dart';

class LandmarkMessage extends StatefulWidget {
  const LandmarkMessage({super.key});

  @override
  State<LandmarkMessage> createState() => _LandmarkMessageState();
}

class _LandmarkMessageState extends State<LandmarkMessage> {
  String landmarkInfoTitle = GlobalLiffData.landmarkInfoTitle ?? '地點名稱';
  String landmarkInfoDescription =
      GlobalLiffData.landmarkInfoDescription ?? '地點敘述';
  String password = GlobalLiffData.password ?? '未知密碼';

  TextStyle boldTextStyle = TextStyle(fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          landmarkInfoTitle,
          style: boldTextStyle,
        ),
        SizedBox(height: 5),
        Text(landmarkInfoDescription),
        SizedBox(height: 10),
        Row(
          children: [
            Text('通關密碼： ', style: boldTextStyle),
            Text(password, style: boldTextStyle),
            SizedBox(width: 10),
            IconButton(
              icon: Icon(Icons.copy, color: Colors.grey),
              onPressed: () {
                Clipboard.setData(ClipboardData(text: password));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Passcode copied to clipboard'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
            ),
          ],
        ),
        Text('請於台南府城 300 LINE 官方聊天室，貼上通關密語並送出換取獎勵！'),
      ],
    );
  }
}
