import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_line_liff/flutter_line_liff.dart';
import '../../service_liff/liff_service.dart';
import '../../service_liff/globalLiffData.dart';
import 'reusableStyles.dart';

class ReusableButtons {
  Widget buildDismissButton(context) {

    FlutterLineLiff flutterlineliff = FlutterLineLiff();
    return FilledButton(
      style: filledButtonStyle,
      onPressed: () {
        flutterlineliff.closeWindow;
      },
      child: const Text('Dismiss'),
    );
  }

  Widget buildSendMessageButton(context) {
    return FilledButton(
      style: filledButtonStyle,
      onPressed: () async {
        final liffService = LiffService();
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
    );
  }

  Widget buildCopyAndRedirectButton(String password) {
    return FilledButton(
      style:filledButtonStyle,
      onPressed: () async {
        Clipboard.setData(ClipboardData(text: password));
        FlutterLineLiff().openWindow(
          params: OpenWindowParams(
            url: 'https://line.me/R/ti/p/%40608iawcf#~',
            external: false,
          ),
        );
      },
      child: const Text('Copy and Redirect'),
    );
  }
}
