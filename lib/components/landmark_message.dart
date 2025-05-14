import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/landmarkData.dart';
import '../constants/globalVariables.dart';
import 'copyButton.dart';

class LandmarkMessage extends StatefulWidget {
  const LandmarkMessage({super.key});

  @override
  State<LandmarkMessage> createState() => _LandmarkMessageState();
}

class _LandmarkMessageState extends State<LandmarkMessage> {
  String landmarkInfoTitle = LandmarkData.landmarkName ?? '地點名稱';
  String landmarkInfoDescription =
      LandmarkData.landmarkDescription ?? '地點敘述';
  String password = LandmarkData.password ?? '未知密碼';

  TextStyle boldTextStyle = const TextStyle(fontWeight: FontWeight.bold, fontSize: 16);

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
        const SizedBox(height: 5),
        Text(landmarkInfoDescription, style: GlobalColors.globalTextStyle),
        const SizedBox(height: 10),
        Row(
          children: [
            Text('通關密碼： ', style: boldTextStyle),
            Text(password, style: boldTextStyle),
            //const SizedBox(width: 6),
            CopyButton(password: password),
            
          ],
        ),
        const Text('請先複製通關密碼，再開啟「府城城垣 300 年」 官方 LINE 對話框、貼上密碼並送出換取任務集章！'),
      ],
    );
  }
}
