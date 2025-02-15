import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_line_liff/flutter_line_liff.dart';
import '../../service_liff/globalLiffData.dart';
import 'reusableButtons.dart';

class RedirectButton extends StatefulWidget {
  const RedirectButton({super.key});

  @override
  State<RedirectButton> createState() => _RedirectButtonState();
}

class _RedirectButtonState extends State<RedirectButton> {
  @override
  Widget build(BuildContext context) {
    final String password = GlobalLiffData.password;

    return ReusableButtons().buildButton(
      context: context,
      text: '領獎去',
      onPressed: () async {
        Clipboard.setData(ClipboardData(text: password));
        FlutterLineLiff().openWindow(
          params: OpenWindowParams(
            url: 'https://line.me/R/ti/p/%40608iawcf#~',
            external: false,
          ),
        );
      },
      
          
    );
  }
}
