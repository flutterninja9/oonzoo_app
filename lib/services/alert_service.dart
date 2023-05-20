import 'package:flutter/material.dart';
import 'package:oonzoo_app/core/app_router.dart';

class AlertService {
  void show(String message) {
    ScaffoldMessenger.of(AppRouter.navigatorKey.currentContext!).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
