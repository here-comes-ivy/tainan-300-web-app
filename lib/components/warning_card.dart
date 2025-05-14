import 'package:flutter/material.dart';
import '../constants/landmarkData.dart';
import '../constants/globalVariables.dart';

class WarningMessage extends StatefulWidget {
  const WarningMessage({super.key});

  @override
  State<WarningMessage> createState() => _WarningMessageState();
}

class _WarningMessageState extends State<WarningMessage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.8,
      ),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: GlobalColors.warningCardColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline, color: Colors.grey[700], ),
          SizedBox(width: 6),
          Expanded(
            child: Text(
              (LandmarkData.isLandmarkPageShown)
                  ? '若未跳轉 Line 官方帳號，請開啟 Line 應用程式後進入「府城城垣 300 年」官方 LINE 對話框，貼上通關密語並送出換取獎勵。'
                  : '若未跳轉 Line 官方帳號，請開啟 Line 應用程式並搜尋「府城城垣 300 年」，加入好友後即可開始參與活動。',
              style: GlobalColors.globalTextStyle
                  .copyWith(color: Color(0xFF595757), fontSize: 11),
              textAlign: TextAlign.left,
              overflow: TextOverflow.visible,
            ),
          ),
        ],
      ),
    );
  }
}
