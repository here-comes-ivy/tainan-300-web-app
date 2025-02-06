import 'package:flutter/material.dart';
import 'package:flutter_line_liff/flutter_line_liff.dart';
import 'service_liff/globalLiffData.dart';
import 'package:firebase_core/firebase_core.dart';
import 'service_firebase/firebase_options.dart';
import 'dart:html' as html;
import 'dart:js' as js;
import 'maplessPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then(
    (value) => print('Firebase initialized.'),
  );

  try {
    await FlutterLineLiff().init(
      config: Config(liffId: '2006821126-aW8ojkoN'),
      successCallback: () {
        debugPrint('LIFF init success.');
      },
      errorCallback: (error) {
        debugPrint(
            'LIFF init error: ${error.name}, ${error.message}, ${error.stack}');
      },
    );
    await FlutterLineLiff().ready;
    print('LIFF is ready.');
  } catch (e) {
    debugPrint('Initialization error: $e');
  }

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color.fromRGBO(218, 188, 76, 1),

        //useMaterial3: true,
        scaffoldBackgroundColor: Colors.white, // 修正顏色值格式
        //scaffoldBackgroundColor: const Color.fromRGBO(242, 239, 233, 1),
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: const Color(0xFF507166), // 修正顏色值格式
              displayColor: const Color(0xFF507166), // 修正顏色值格式
            ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          shadowColor: Colors.black.withValues(alpha: 0.2),
          elevation: 10,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: const Color(0xFF507166),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        // colorScheme: ColorScheme.fromSeed(
        //   seedColor: Colors.white,
        // ),
      ),
      home: MaplessPage(),
    );
  }
}
