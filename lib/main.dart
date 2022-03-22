import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_mvcs_counter/models/user.dart';
import 'package:riverpod_mvcs_counter/views/auth/auth_view.dart';
import 'package:riverpod_mvcs_counter/views/random_number/random_number_view.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String currentUser = ref
        .watch(user)
        .when(data: (data) => data, error: (e, s) => "", loading: () => "");

    return MaterialApp(
      home: currentUser.isNotEmpty ? const RandomNumberView() : const AuthView(),
    );
  }
}
