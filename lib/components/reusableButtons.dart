import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_line_liff/flutter_line_liff.dart';
import '../../service_liff/liff_service.dart';

class ReusableButtons {

  final filledButtonStyle = FilledButton.styleFrom(
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.zero,
  ),
);

  Widget buildButton(
      {required String text, required Function() onPressed, context}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shadowColor: Colors.grey,
        backgroundColor: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      onPressed: onPressed,
      child: Text(text, style: TextStyle(
              fontSize: 14,
              overflow: TextOverflow.visible,
              color: Colors.white,
              fontWeight: FontWeight.bold)),
    );
  }

  //   Widget buildCopyAndRedirectButton({required String password}) {
  //   return buildButton(
  //     onPressed: () async {
  //       Clipboard.setData(ClipboardData(text: password));
  //       FlutterLineLiff().openWindow(
  //         params: OpenWindowParams(
  //           url: 'https://line.me/R/ti/p/%40608iawcf#~',
  //           external: false,
  //         ),
  //       );
  //     },
  //     text: '領獎去',
  //   );
  // }


  // Widget buildDismissButton(context) {
  //   return buildButton(
  //     onPressed: () {
  //       FlutterLineLiff().closeWindow();
  //     },
  //     text: 'Dismiss',
  //   );
  // }

  // Widget buildSendMessageButton(context) {
  //   return buildButton(
  //     onPressed: () async {
  //       final liffService = LiffService();
  //       bool success = await liffService.sendUserMessage();
  //       String errorMessage = liffService.getError;

  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text(
  //             success
  //                 ? 'Message sent successfully!'
  //                 : 'Failed to send message: $errorMessage',
  //           ),
  //           backgroundColor: success ? Colors.green : Colors.red,
  //           duration: const Duration(seconds: 2),
  //         ),
  //       );
  //     },
  //     text: 'Send Message',
  //   );
  // }


}
