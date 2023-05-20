import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:oonzoo_app/core/app_router.dart';
import 'package:oonzoo_app/viewmodels/auth_viewmodel.dart';
import 'package:oonzoo_app/viewmodels/cart_viewmodel.dart';
import 'package:oonzoo_app/viewmodels/splash_viewmodel.dart';
import 'package:oonzoo_app/views/splash_view.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const OnzooApp());
}

class OnzooApp extends StatelessWidget {
  const OnzooApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SplashViewModel()),
        ChangeNotifierProvider(create: (context) => AuthViewModel()),
        ChangeNotifierProvider(create: (context) => CartViewModel()),
      ],
      child: MaterialApp(
        navigatorKey: AppRouter.navigatorKey,
        initialRoute: SplashView.routeName,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            color: Colors.white,
            elevation: 1,
            surfaceTintColor: Colors.grey,
            titleTextStyle: TextStyle(
              fontWeight: FontWeight.w300,
              color: Colors.black,
            ),
          ),
        ),
        onGenerateRoute: AppRouter.onGenerateRoute,
      ),
    );
  }
}
