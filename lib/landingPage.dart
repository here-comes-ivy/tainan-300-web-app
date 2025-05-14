import 'package:flutter/material.dart';
import 'components/redirect_button.dart';
import 'components/warning_card.dart';
import 'components/landmarkDetails_card.dart';
import 'constants/landmarkData.dart';
import 'dart:js_interop';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'services/analyticsProvider.dart';

class LandingPage extends StatefulWidget {
  @override
  State<LandingPage> createState() => _LandingPageState();
}

@JS('window')
external Window get window;

@JS()
@staticInterop
class Window {}

extension WindowExtension on Window {
  external void hideSplashScreen();
}

class _LandingPageState extends State<LandingPage>
    with SingleTickerProviderStateMixin {
  late Future<void> _initDataFuture;

  final landmarkData = LandmarkData();
  bool _hasLoggedCompletion = false;
  bool _hasAddedCallback = false;

  @override
  void initState() {
    super.initState();
    _initDataFuture = _initializeAll();
  }

  Future<void> _initializeAll() async {
    await landmarkData.getDataFromFirestore();
  }

  @override
  Widget build(BuildContext context) {
    double imgHeight = MediaQuery.of(context).size.height * 0.15;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: FutureBuilder<void>(
        future: _initDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              !landmarkData.isInitialized) {
            return Center(
              child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor),
            );
          }
          if (snapshot.connectionState == ConnectionState.done &&
              !_hasAddedCallback) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (kIsWeb) {
                window.hideSplashScreen();
              }

              if (!_hasLoggedCompletion) {
                _hasLoggedCompletion = true;
                final analyticsProvider =
                    Provider.of<AnalyticsProvider>(context, listen: false);
                analyticsProvider.trackPageLoadComplete();
              }
            });

            return SingleChildScrollView(
              child: Column(
                children: [
                  Stack(children: [
                    Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: imgHeight,
                          child: Image.asset(
                            'assets/images/welcomePage.webp',
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter,
                          ),
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  LandmarkdetailsCard(),
                                  const SizedBox(height: 12),
                                  SizedBox(
                                    width: screenWidth * 0.6,
                                    child: RedirectButton(),
                                  ),
                                  const SizedBox(height: 16),
                                  SizedBox(
                                    width: screenWidth * 0.8,
                                    child: WarningMessage(),
                                  ),
                                  const SizedBox(height: 50),
                                  Text('Copyright © 2025 NanNova Labs',
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.black
                                              .withValues(alpha: 0.5))),
                                  const SizedBox(height: 12),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: imgHeight,
                          child: Image.asset(
                            'assets/images/welcomePage.webp',
                            fit: BoxFit.cover,
                            alignment: Alignment.bottomCenter,
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      top: imgHeight - 40,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Material(
                          elevation: 4,
                          shape: CircleBorder(),
                          child: CircleAvatar(
                            radius: 40,
                            foregroundImage:
                                AssetImage('assets/images/LOGO_optimized.webp'),
                            backgroundColor: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ]),
                ],
              ),
            );
          }
          return Center(child: Text('發生錯誤，請稍後再試。')); // Default return statement
        },
      ),
    );
  }
}
