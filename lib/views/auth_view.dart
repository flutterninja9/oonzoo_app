import 'package:flutter/material.dart';
import 'package:oonzoo_app/viewmodels/auth_viewmodel.dart';
import 'package:oonzoo_app/views/login_view.dart';
import 'package:oonzoo_app/views/sign_up_view.dart';
import 'package:provider/provider.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  static const routeName = '/auth';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<AuthViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.isRegistering) {
              return const SignUpView();
            }
            return const LoginView();
          },
        ),
      ),
    );
  }
}
