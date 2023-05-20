import 'package:flutter/material.dart';
import 'package:oonzoo_app/core/loader.dart';
import 'package:oonzoo_app/viewmodels/splash_viewmodel.dart';
import 'package:provider/provider.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    context.read<SplashViewModel>().checkAuthenticated();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: const [
          Spacer(),
          Center(
            child: FlutterLogo(
              size: 150,
            ),
          ),
          Spacer(),
          LoaderWidget(
            text: 'Please wait...',
          ),
        ],
      ),
    );
  }
}
