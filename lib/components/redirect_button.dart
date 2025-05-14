import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/landmarkData.dart';
import 'package:url_launcher/url_launcher.dart';
import '../services/analyticsProvider.dart';
import 'package:provider/provider.dart';

class RedirectButton extends StatefulWidget {
  const RedirectButton({super.key});

  @override
  State<RedirectButton> createState() => _RedirectButtonState();
}

class _RedirectButtonState extends State<RedirectButton> {
  @override
  Widget build(BuildContext context) {
    final String password = LandmarkData.password ?? '未知密碼';
    const String url = 'https://line.me/R/ti/p/@985xszkh';
    var onPressedRedirect = () async {
      await Clipboard.setData(ClipboardData(text: password));

      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
      } else {
        throw '無法開啟連結 $url';
      }

      await Provider.of<AnalyticsProvider>(context, listen: false)
          .logExternalLinkClicked(url);
    };

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shadowColor: Colors.grey,
        backgroundColor: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      onPressed: onPressedRedirect,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 14),
        child: Text('前往 LINE 官方帳號',
            style: TextStyle(
                fontSize: 14,
                overflow: TextOverflow.visible,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
      ),
    );
  }
}
