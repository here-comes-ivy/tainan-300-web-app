import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_line_liff/flutter_line_liff.dart';
import '../../service_liff/liff_service.dart';
import '../../service_liff/globalLiffData.dart';

class RedirectButton extends StatefulWidget {
  const RedirectButton({super.key});

  @override
  State<RedirectButton> createState() => _RedirectButtonState();
}

class _RedirectButtonState extends State<RedirectButton> {
  @override
  Widget build(BuildContext context) {
    final String password = GlobalLiffData.password;

    return FilledButton(
      style: FilledButton.styleFrom(
        shadowColor: Colors.grey,
        backgroundColor: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      onPressed: () async {
        Clipboard.setData(ClipboardData(text: password));
        FlutterLineLiff().openWindow(
          params: OpenWindowParams(
            url: 'https://line.me/R/ti/p/%40608iawcf#~',
            external: false,
          ),
        );
      },
      child: Text('領獎去',
          style: TextStyle(
              overflow: TextOverflow.visible,
              fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold)),
    );
  }
}
