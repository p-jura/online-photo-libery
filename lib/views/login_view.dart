import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:online_photo_libery/bloc/app_bloc.dart';
import 'package:online_photo_libery/extension/if_debugging.dart';

class LoginView extends HookWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController =
        useTextEditingController(text: 'test@test.pl'.ifDebugging);
    final passwordController =
        useTextEditingController(text: 'password'.ifDebugging);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Log in',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: 'Enter your email',
              ),
            ),
            TextField(
              controller: passwordController,
              keyboardType: TextInputType.text,
              obscureText: true,
              obscuringCharacter: '◼',
              decoration: const InputDecoration(
                hintText: 'Enter your password',
              ),
            ),
            TextButton(
              onPressed: () {
                final email = emailController.text;
                final password = passwordController.text;
                context.read<AppBloc>().add(
                      AppEventLogIn(
                        email: email,
                        password: password,
                      ),
                    );
              },
              child: const Text(
                'Log in',
              ),
            ),
            TextButton(
              onPressed: () {
                context.read<AppBloc>().add(
                      const AppEventGoToRegistration(),
                    );
              },
              child: const Text(
                'Not registered? Register here.',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
