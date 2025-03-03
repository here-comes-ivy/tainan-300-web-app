import 'package:flutter/material.dart';
import 'package:explore_tainan_web/global_variables/globalDBData.dart';

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
        maxWidth: MediaQuery.of(context).size.width,
      ),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Color.fromRGBO(254, 248, 227, 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(Icons.error, color: Colors.grey[700]),
          SizedBox(width: 6),
          Expanded(
            child: Text(
              (GlobalDBData.landmarkDetails.isNotEmpty)
                  ? '若未跳轉聊天室，請開啟 LINE APP 後進入台南府城 300 LINE 官方帳號聊天室，貼上通關密語並送出換取獎勵。'
                  : '若未跳轉聊天室，請開啟 LINE APP 並搜尋「台南府城 300 LINE 官方帳號」、加入好友後即可開始參與活動，完成指定任務即可獲得獎品和店家優惠唷！',
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 14,
              ),
              textAlign: TextAlign.left,
              overflow: TextOverflow.visible,
            ),
          ),
        ],
      ),
    );
  }
}
