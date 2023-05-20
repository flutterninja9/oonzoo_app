import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:oonzoo_app/core/app_router.dart';
import 'package:oonzoo_app/services/auth_service.dart';
import 'package:oonzoo_app/views/auth_view.dart';
import 'package:oonzoo_app/views/home_view.dart';

class SplashViewModel with ChangeNotifier {
  AuthState _authState = AuthState.unknown;
  User? user;
  final AuthService _authService = AuthService();

  AuthState get authState => _authState;

  Future<void> checkAuthenticated() async {
    _authState = await _authService.getSignedInState();
    await Future.delayed(const Duration(seconds: 1));
    switch (_authState) {
      case AuthState.authenticated:
        user = await _authService.getSignedInUser();
        AppRouter.popAndPush(HomeView.routeName);
        break;
      case AuthState.unAuthenticated:
        AppRouter.popAndPush(AuthView.routeName);
        break;
      case AuthState.unknown:
        break;
    }
  }
}
