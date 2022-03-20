import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_mvcs_counter/views/auth/auth_view_controller.dart';

class AuthView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isLoading = ref.watch(authViewController);
    var viewController = ref.read(authViewController.notifier);
    return Scaffold(
        body: Center(
            child: isLoading
                ? CircularProgressIndicator(
                    key: Key('loginLoading'),
                  )
                : TextButton(
                    onPressed: viewController.login,
                    child: Text(
                      "Login",
                      key: Key('loginButton'),
                    ))));
  }
}
