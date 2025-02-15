import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_line_liff/flutter_line_liff.dart';
import '../../service_liff/liff_service.dart';
import '../../service_liff/globalLiffData.dart';
import 'reusableButtons.dart';

class SendMessageButton extends StatefulWidget {
  const SendMessageButton({super.key});

  @override
  State<SendMessageButton> createState() => _SendMessageButtonState();
}

class _SendMessageButtonState extends State<SendMessageButton> {
  @override
  Widget build(BuildContext context) {
    return ReusableButtons().buildButton(
      context: context,
      text: '送出訊息',
      onPressed: () async {
        final liffService = LiffService();
        bool success = await liffService.sendUserMessage();
        String errorMessage = liffService.getError;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              success ? '成功送出通關密語！' : '無法送出訊息: $errorMessage',
            ),
            backgroundColor: success ? Colors.green : Colors.red,
            duration: const Duration(seconds: 2),
          ),
        );
      },
      
    );
  }
}
