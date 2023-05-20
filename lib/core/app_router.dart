import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:oonzoo_app/views/auth_view.dart';
import 'package:oonzoo_app/views/cart_view.dart';
import 'package:oonzoo_app/views/home_view.dart';
import 'package:oonzoo_app/views/product_detail_view.dart';
import 'package:oonzoo_app/views/splash_view.dart';

class AppRouter {
  static final navigatorKey = GlobalKey<NavigatorState>();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case ProductDetailView.routeName:
        return MaterialPageRoute(
          builder: (_) => ProductDetailView(
            id: settings.arguments as String,
          ),
        );
      case HomeView.routeName:
        return MaterialPageRoute(
          builder: (_) => HomeView(),
        );
      case SplashView.routeName:
        return MaterialPageRoute(
          builder: (_) => const SplashView(),
        );
      case AuthView.routeName:
        return MaterialPageRoute(
          builder: (_) => const AuthView(),
        );
      case CartView.routeName:
        return MaterialPageRoute(
          builder: (_) => const CartView(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }

  static Future<dynamic> navigateTo(String routeName, {Object? args}) {
    log('navigateTo $routeName');
    return navigatorKey.currentState!.pushNamed(routeName, arguments: args);
  }

  static Future<dynamic> popAndPush(String routeName) {
    log('popAndPush $routeName');
    return navigatorKey.currentState!.pushReplacementNamed(routeName);
  }

  static void goBack() {
    log('goBack');
    return navigatorKey.currentState!.pop();
  }
}
