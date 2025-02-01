import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_line_liff/flutter_line_liff.dart' as line_liff;
import 'widget_landingPage/landingPage_checkInDialog.dart';
import 'service_liff/globalLiffData.dart';
import 'checkIn_message.dart';
import 'reusableButtons.dart';

class MaplessPage extends StatefulWidget {
  @override
  State<MaplessPage> createState() => _MaplessPageState();
}

class _MaplessPageState extends State<MaplessPage> {
  late Future<void> _initDataFuture;
  @override
  void initState() {
    super.initState();
    _initDataFuture = _initializeData();
  }

  Future<void> _initializeData() async {
    await GlobalLiffData.getAllLiffData();
  }

  @override
  Widget build(BuildContext context) {
    ReusableButtons textButtons = ReusableButtons();

    return Scaffold(
      body: FutureBuilder<void>(
        future: _initDataFuture,
        builder: (context, snapshot) {
          if (!GlobalLiffData.isInitialized) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Scaffold(
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 20),
                      CheckinMessage(),
                      SizedBox(height: 20),
                      buttonSizedBox(
                        textButtons.buildDismissButton(context),
                      ),
                      SizedBox(height: 20),
                      buttonSizedBox(
                        textButtons.buildSendMessageButton(context),
                      ),
                      SizedBox(height: 20),
                      buttonSizedBox(
                        textButtons.buildCopyAndRedirectButton(
                            GlobalLiffData.password ?? 'Unknown Password'),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget buttonSizedBox(Widget child) {
    return SizedBox(width: double.infinity, height: 50, child: child);
  }
}
