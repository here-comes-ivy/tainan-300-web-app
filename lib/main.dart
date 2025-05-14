import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'services/firebase_options.dart';
import 'landingPage.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'constants/globalVariables.dart';
import 'package:provider/provider.dart';
import 'services/analyticsProvider.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);
  
  // 創建一個全局的 AnalyticsProvider 實例
  final analyticsProvider = AnalyticsProvider();
  
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  
  // 記錄啟動時間
  analyticsProvider.initPageLoadTracking();
  
  
  // 將 analyticsProvider 傳遞給 MyApp
  runApp(MyApp(analyticsProvider: analyticsProvider));
}

class MyApp extends StatefulWidget {
  final AnalyticsProvider analyticsProvider;
  
  const MyApp({Key? key, required this.analyticsProvider}) : super(key: key);
  
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static final FirebaseAnalyticsObserver observer =
    FirebaseAnalyticsObserver(analytics: analytics);
  
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
    return ChangeNotifierProvider.value(
      // 使用從 main() 函數傳遞的實例
      value: widget.analyticsProvider,
      child: MaterialApp(
        title: "府城城垣 300 年 任務集章活動",
        theme: ThemeData(
          primaryColor: GlobalColors.primaryColor,
          useMaterial3: false,
          scaffoldBackgroundColor: Colors.white,
          textTheme: Theme.of(context).textTheme.apply(
            fontFamily: 'NotoSansTC',
            fontFamilyFallback: ['sans-serif'],
            bodyColor: GlobalColors.textColor,
            displayColor: GlobalColors.textColor,
          )
        ),
        navigatorObservers: [MyApp.observer],
        home: LandingPage()
      ),
    );
  }
}