import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'landingPage.dart';
import 'service_liff/globalLiffData.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Future<void> _initDataFuture;

  @override
  void initState() {
    super.initState();
    _initDataFuture = _initializeAll();
  }

  Future<void> _initializeAll() async {
    await Future.wait([
      GlobalLiffData.getAllLiffData(),
      Future.delayed(const Duration(seconds: 5)),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: _initDataFuture,
        builder: (context, snapshot) {
          Widget content = Center(
            child: Lottie.asset(
              "assets/animations/IF_LOGO_.json",
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width * 0.8,
            ),
          );

          if (snapshot.connectionState == ConnectionState.done) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: ((context) => LandingPage()),
                ),
              );
            });
          }

          return content;
        },
      ),
    );
  }
}