// import 'package:firebase_analytics/firebase_analytics.dart';
// import 'package:firebase_analytics/observer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigatorManager {
  factory NavigatorManager() => _instance;

  static final _instance = NavigatorManager.private();

  GlobalKey<NavigatorState> _navigatorKey;
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  RouteObserver<PageRoute> _routeObserver;
  RouteObserver<PageRoute> get routeObserver => _routeObserver;

  NavigatorManager.private() {
    _navigatorKey = GlobalKey();
    // _routeObserver = FirebaseAnalyticsObserver(
    //   analytics: FirebaseAnalytics(),
    // );
  }
}
