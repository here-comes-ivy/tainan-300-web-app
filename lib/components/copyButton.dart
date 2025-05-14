import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../services/analyticsProvider.dart';
import 'package:provider/provider.dart';

class CopyButton extends StatefulWidget {
  final String password;

  const CopyButton({Key? key, required this.password}) : super(key: key);

  @override
  _CopyButtonState createState() => _CopyButtonState();
}

class _CopyButtonState extends State<CopyButton> {
  bool _isCopied = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashRadius: 20,
      icon: Icon(
        _isCopied ? Icons.file_copy : Icons.copy,
        color: Colors.grey,
      ),
      onPressed: () {
        Clipboard.setData(ClipboardData(text: widget.password));
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('密碼已複製至剪貼簿！', style: TextStyle(fontFamily: 'NotoSansTC')),
            duration: Duration(seconds: 2),
          ),
        );

        setState(() {
          _isCopied = true;
        });
        Provider.of<AnalyticsProvider>(context, listen: false)
                .markTextCopied(widget.password);
      },
    );
  }
}
