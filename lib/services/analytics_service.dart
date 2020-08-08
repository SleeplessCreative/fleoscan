import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AnalyticsService {
  final FirebaseAnalytics _analytics = FirebaseAnalytics();

  FirebaseAnalyticsObserver getAnalyticsObserver() =>
      FirebaseAnalyticsObserver(analytics: _analytics);

  //User Scan Properties
  Future setUserProperties({@required String userId}) async {
    await _analytics.setUserId(userId);
  }

  Future logScanSuccess({String scanResult}) async {
    await _analytics.logEvent(
      name: 'scan_success',
      parameters: {'scan_result': scanResult},
    );
  }

  Future logScanFailed({String errorMessage}) async {
    await _analytics.logEvent(
      name: 'scan_failed',
      parameters: {
        'error': errorMessage,
      },
    );
  }
}
