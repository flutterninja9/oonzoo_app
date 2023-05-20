import 'package:flutter/material.dart';
import 'package:oonzoo_app/core/loader.dart';
import 'package:oonzoo_app/viewmodels/auth_viewmodel.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  static const routeName = '/login';

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthViewModel>(
      builder: (context, state, child) {
        return Column(
          children: [
            const Spacer(),
            const FlutterLogo(size: 80),
            const Text('Sign in'),
            const SizedBox(height: 12),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email_outlined),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.password_outlined),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            if (state.isBusy)
              const LoaderWidget(text: 'Signing in')
            else
              ElevatedButton(
                onPressed: () {
                  state.login(
                    _emailController.text,
                    _passwordController.text,
                  );
                },
                child: const Text('Sign in'),
              ),
            if (!state.isBusy)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Don\'t have an account? '),
                  TextButton(
                    onPressed: () {
                      state.toggleRegistering();
                    },
                    child: const Text('Sign up'),
                  ),
                ],
              ),
            const Spacer(),
          ],
        );
      },
    );
  }
}
