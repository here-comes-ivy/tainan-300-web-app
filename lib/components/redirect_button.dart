import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_line_liff/flutter_line_liff.dart';
import '../../service_liff/globalLiffData.dart';

class RedirectButton extends StatefulWidget {
  const RedirectButton({super.key});

  @override
  State<RedirectButton> createState() => _RedirectButtonState();
}

class _RedirectButtonState extends State<RedirectButton> {
  @override
  Widget build(BuildContext context) {
    final String password = GlobalLiffData.password ?? '未知密碼';
    FlutterLineLiff flutterLineLiff = FlutterLineLiff.instance;
    var onPressedRedirect = () async {
      Clipboard.setData(ClipboardData(text: password));
      flutterLineLiff.openWindow(
        params: OpenWindowParams(
          url: 'https://line.me/R/ti/p/%40608iawcf#~',
          external: false,
        ),
      );
    };

    var onPressedSendMessage = () async {
      String getError = '';
      bool success;
      try {
        await flutterLineLiff.sendMessages(messages: [
          TextMessage(text: password),
        ]);
        success = true;
      } catch (e) {
        print('Error sending user message: $e');
        getError = e.toString();
        success = false;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            success ? '成功送出通關密語！' : '無法送出訊息: $getError',
          ),
          backgroundColor: success ? Colors.green : Colors.red,
          duration: const Duration(seconds: 2),
        ),
      );
      // await Future.delayed(const Duration(seconds: 2));
      // FlutterLineLiff().closeWindow();
    };

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shadowColor: Colors.grey,
        backgroundColor: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      onPressed: GlobalLiffData.landmarkDetails.isEmpty
          ? onPressedRedirect
          : onPressedSendMessage,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 14),
        child: Text(
            GlobalLiffData.isSendMessage? '前往 LINE 官方帳號' : '送出訊息',
            style: TextStyle(
                fontSize: 14,
                overflow: TextOverflow.visible,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
      ),
    );
  }
}
