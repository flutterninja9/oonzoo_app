import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:oonzoo_app/core/app_router.dart';
import 'package:oonzoo_app/services/alert_service.dart';
import 'package:oonzoo_app/services/auth_service.dart';
import 'package:oonzoo_app/views/home_view.dart';
import 'package:oonzoo_app/views/splash_view.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();
  bool isRegistering = false;
  bool isBusy = false;

  Future<void> login(String email, String password) async {
    try {
      isBusy = true;
      notifyListeners();

      await _authService.loginWithEmailAndPassword(email, password);

      isBusy = false;
      AppRouter.popAndPush(HomeView.routeName);
    } catch (e) {
      isBusy = false;
      notifyListeners();
      log(e.toString());
      AlertService().show(e.toString());
    }
  }

  Future<void> register(String email, String password) async {
    try {
      isBusy = true;
      notifyListeners();

      await _authService.registerWithEmailAndPassword(email, password);
      isBusy = false;
      AppRouter.popAndPush(HomeView.routeName);
    } catch (e) {
      isBusy = false;
      notifyListeners();
      log(e.toString());
      AlertService().show(e.toString());
    }
  }

  Future<void> logout() async {
    try {
      await _authService.logout();
      AppRouter.popAndPush(SplashView.routeName);
    } catch (e) {
      log(e.toString());
      AlertService().show(e.toString());
    }
  }

  Future<void> checkAuthenticated() async {
    try {
      await _authService.getSignedInState();
      notifyListeners();
    } catch (e) {
      log(e.toString());
      AlertService().show(e.toString());
    }
  }

  void toggleRegistering() {
    isRegistering = !isRegistering;
    notifyListeners();
  }
}
