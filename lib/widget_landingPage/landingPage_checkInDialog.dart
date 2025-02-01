import '../service_liff/globalLiffData.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import '../service_liff/liff_service.dart';
import 'package:flutter_line_liff/flutter_line_liff.dart';
import 'package:intl/intl.dart';
import 'package:explore_tainan_web/reusableButtons.dart';
import '../checkIn_message.dart';

class CheckInDialog {
  static Future<void> showCheckInDialog({
    required BuildContext context,
  }) async {
    final String userName = GlobalLiffData.userName ?? 'Unknown User';

    String landmark = GlobalLiffData.landmarkName ?? 'Unknown Landmark';
    String password = GlobalLiffData.password ?? 'Unknown Password';

    String dateTime = DateFormat('yyyy-MM-dd kk:mm').format(DateTime.now());

    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Hello $userName!',
              style: TextStyle(fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CheckinMessage(),
              Text('恭喜你成功取得「$landmark」的通關密碼：'),
              Row(
                children: [
                  Text('$password',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(width: 10),
                  IconButton(
                    icon: Icon(Icons.copy),
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
              Text('在官方聊天室輸入通關密語並送出訊息後，即可累積寶石或取得獎勵。'),
              Text('請務必在 $dateTime 前完成通關，逾時將無法獲得獎勵。'),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Dismiss'),
            ),
            TextButton(
              onPressed: () async {
                LiffService liffService = LiffService();
                bool success = await liffService.sendUserMessage();
                String errorMessage = liffService.getError;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      success
                          ? 'Message sent successfully!'
                          : 'Failed to send message: $errorMessage',
                    ),
                    backgroundColor: success ? Colors.green : Colors.red,
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
              child: const Text('Send Message'),
            ),
            TextButton(
              onPressed: () async {
                Clipboard.setData(ClipboardData(text: password));
                FlutterLineLiff().openWindow(
                  params: OpenWindowParams(
                    url: 'https://line.me/R/ti/p/%40608iawcf#~',
                    external: false,
                  ),
                );
              },
              child: const Text('Copy & Redeem'),
            ),
          ],
        );
      },
    );
  }
}
