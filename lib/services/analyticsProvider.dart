import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'dart:js_interop';

@JS()
external JSObject get globalThis;

@JS('pageStartTime')
external int? get pageStartTime;

class AnalyticsProvider extends ChangeNotifier {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
  bool _hasCopiedText = false;
  DateTime? _appStartTime;
  DateTime? _jsPageStartTime;

  bool get hasCopiedText => _hasCopiedText;

  void initPageLoadTracking() {
    int? jsStartTime;
    try {
      jsStartTime = pageStartTime;
    } catch (e) {}

    _appStartTime = DateTime.now();
    _jsPageStartTime = jsStartTime != null
        ? DateTime.fromMillisecondsSinceEpoch(jsStartTime.toInt())
        : null;
  }

  Future<void> trackPageLoadComplete() async {
    final loadEndTime = DateTime.now();
    final flutterLoadDurationMs =
        loadEndTime.difference(_appStartTime!).inMilliseconds;

    // 參數
    final Map<String, dynamic> params = {
      'flutter_load_time_ms': flutterLoadDurationMs,
      'end_time': loadEndTime.toIso8601String(),
    };

    // 如果有JS開始時間，計算總載入時間
    if (_jsPageStartTime != null) {
      final totalLoadDurationMs =
          loadEndTime.difference(_jsPageStartTime!).inMilliseconds;
      params['total_load_time_ms'] = totalLoadDurationMs;
      params['js_start_time'] = _jsPageStartTime!.toIso8601String();
    }

    await _analytics.logEvent(
      name: 'page_load_complete',
      parameters: params.cast<String, Object>(),
    );
  }

  void markTextCopied(String copiedText) async {
    _hasCopiedText = true;

    await _analytics.logEvent(
      name: 'text_copied',
      parameters: {
        'text_content': copiedText,
        'timestamp': DateTime.now().toString(),
      },
    );
    notifyListeners();
  }

  Future<void> logExternalLinkClicked(String linkUrl) async {
    await _analytics.logEvent(
      name: 'external_link_clicked',
      parameters: {
        'link_url': linkUrl,
        'copied_text_first': _hasCopiedText.toString(),
        'timestamp': DateTime.now().toString(),
      },
    );

    if (!_hasCopiedText) {
      await _analytics.logEvent(
        name: 'direct_link_without_copy',
        parameters: {
          'link_url': linkUrl,
          'timestamp': DateTime.now().toString(),
        },
      );
    }
    notifyListeners();
  }
}
