import 'package:flutter/material.dart';
import '../../service_liff/globalLiffData.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CheckinMessage extends StatefulWidget {
  CheckinMessage({super.key});

  @override
  State<CheckinMessage> createState() => _CheckinMessageState();
}

class _CheckinMessageState extends State<CheckinMessage> {
  final String userName = GlobalLiffData.userName ?? 'Unknown User';

  String landmark = GlobalLiffData.landmarkName ?? 'Unknown Landmark';

  String password = GlobalLiffData.password ?? '未知密碼';

  String dateTime = DateFormat('yyyy-MM-dd kk:mm').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          TextSpan(
            children: [
              TextSpan(
                text: '恭喜你成功取得 ',
              ),
              TextSpan(
                text: landmark,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: ' 的通關密碼：',
              ),
            ],
          ),
        ),
        Row(
          children: [
            Text('$password', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
        // Text('在官方聊天室輸入通關密語並送出訊息後，即可累積寶石或取得獎勵。'),
        // Text('請務必在 $dateTime 前完成通關，逾時將無法獲得獎勵。'),
      ],
    );
  }
}
