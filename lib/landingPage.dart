import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'widget_map/mapWidget.dart';
import 'widget_landingPage/landingPage_header.dart';
import 'package:flutter_line_liff/flutter_line_liff.dart';
import 'service_firebase/firebase_service.dart';
import 'widget_landingPage/landingPage_liffInfoButton.dart';
import 'widget_landingPage/landingPage_checkInDialog.dart';
import 'service_liff/globalLiffData.dart';

class LandingPage extends StatefulWidget {
  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  late Future<void> _initDataFuture;
  @override
  void initState() {
    super.initState();
    _initDataFuture = _initializeData();
  }

  Future<void> _initializeData() async {
    
    await GlobalLiffData.getAllLiffData();
    try {
        await Future.delayed(Duration.zero, () {
          CheckInDialog.showCheckInDialog(context: context);
        });
  
    } catch (e) {
      print('Error showing dialog: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    String firestoreDetails = GlobalLiffData.allLandmarkDetails.toString();

    return Scaffold(
      body: FutureBuilder<void>(
        future: _initDataFuture,
        builder: (context, snapshot) {
          if (!GlobalLiffData.isInitialized) {
            return Center(child: CircularProgressIndicator());
          } else {
            return SafeArea(
              minimum: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              maintainBottomViewPadding: true,
              child: Column(
                children: [
                  LandingPageHeader(),
                  const Expanded(
                    flex: 80,
                    child: MapWidget(),
                  ),
                  const SizedBox(height: 20),
                  LiffInfoButton(),
                  const SizedBox(height: 20),
                  Text('Firestore Details: $firestoreDetails\n\n'),

                ],
              ),
            );
          }
        },
      ),
    );
  }
}
