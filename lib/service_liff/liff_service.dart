import 'package:flutter/material.dart';
import 'package:flutter_line_liff/flutter_line_liff.dart';
import 'globalLiffData.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class LiffService {
  final liff = GlobalLiffData.liffInstance;
  String getError = '';
  String password = GlobalLiffData.password ?? 'No password available';

  Future<bool> sendUserMessage() async {
      try {
        await liff.sendMessages(messages: [
          TextMessage(text: password),
        ]);
        return true;
      } catch (e) {
        print('Error sending user message: $e');
        getError = e.toString();
        return false;
      }
    
  }
}
