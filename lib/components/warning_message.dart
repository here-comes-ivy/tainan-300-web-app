import 'package:flutter/material.dart';

class WarningMessage extends StatefulWidget {
  const WarningMessage({super.key});

  @override
  State<WarningMessage> createState() => _WarningMessageState();
}

class _WarningMessageState extends State<WarningMessage> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.error),
        SizedBox(width: 6),
        Expanded(
          child: Text.rich(
            style: TextStyle(fontSize: 14, color: Colors.black),
            textAlign: TextAlign.left,
            overflow: TextOverflow.visible,
            TextSpan(
              children: [
                TextSpan(
                  text: '若未自動跳轉 Line 官方帳號，',
                ),
                TextSpan(
                  text: '請複製通關密語',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: '，在台南府城 300 官方帳號聊天室貼上並送出。', 
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
