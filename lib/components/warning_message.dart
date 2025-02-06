import 'package:flutter/material.dart';

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
            child: Text.rich(
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 14,
              ),
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
      ),
    );
  }
}
