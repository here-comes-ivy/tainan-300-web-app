import 'package:flutter/material.dart';
import 'package:explore_tainan_web/global_variables/globalLiffData.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class WelcomingMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userName = GlobalLiffData.userName;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Center(
          child: Text(
            '「一府 x iF」遊城打卡活動首頁',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Text.rich(
          TextSpan(
            text: 'Hello',
            children: [
              if (userName != null && userName.isNotEmpty)
                TextSpan(children: [
                  const TextSpan(text: ' '),
                  TextSpan(
                    text: userName,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const TextSpan(text: ' '),
                ]),
              const TextSpan(text: '！'),
            ],
          ),
        ),
        const Text('歡迎加入「一府 x iF」遊城打卡活動。'),
        Text.rich(
          const TextSpan(
            text: '請先與 ',
            children: [
              TextSpan(
                text: '台南府城 300 LINE 官方帳號',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(text: ' 成為好友，才能取得活動資訊、任務清單和獎勵唷！'),
            ],
          ),
        ),
      ],
    );
  }
}
