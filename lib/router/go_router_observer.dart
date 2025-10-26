import 'package:flutter/material.dart';

class GoRouterObserver extends NavigatorObserver {
  final void Function(Route<dynamic> currentRoute)? onPush;
  final void Function(Route<dynamic>? currentRoute)? onPop;

  GoRouterObserver({this.onPop, this.onPush});

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    onPush?.call(route);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    onPop?.call(previousRoute);
  }
}
