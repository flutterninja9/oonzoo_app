import 'package:flutter/material.dart';
import 'package:oonzoo_app/core/loader.dart';
import 'package:oonzoo_app/viewmodels/auth_viewmodel.dart';
import 'package:provider/provider.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  static const routeName = '/sign-up';

  @override
  State<SignUpView> createState() => SignUpViewState();
}

class SignUpViewState extends State<SignUpView> {
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
            const Text('Sign up'),
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
                prefixIcon: Icon(Icons.password_outlined),
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            if (state.isBusy)
              const LoaderWidget(text: 'Signing up')
            else
              ElevatedButton(
                onPressed: () {
                  state.register(
                    _emailController.text,
                    _passwordController.text,
                  );
                },
                child: const Text('Sign up'),
              ),
            if (!state.isBusy)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account? '),
                  TextButton(
                    onPressed: () {
                      state.toggleRegistering();
                    },
                    child: const Text('Login'),
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
