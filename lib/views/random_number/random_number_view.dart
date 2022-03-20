import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_mvcs_counter/models/user.dart';
import 'package:riverpod_mvcs_counter/models/random_number.dart';
import 'package:riverpod_mvcs_counter/views/random_number/random_number_view_controller.dart';

class RandomNumberView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isLoading = ref.watch(randomNumberViewController);
    String currentUser = ref
        .watch(user)
        .when(data: (data) => data, error: (e, s) => "", loading: () => "");
    var viewController = ref.watch(randomNumberViewController.notifier);

    return Scaffold(
      appBar: AppBar(
        key: ValueKey('RandomNumberView Appbar'),
        title: Text("Hello, $currentUser"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: ref.watch(randomNumberModel).when(
                  data: (data) => Text("Random Number : $data"),
                  error: (e, s) => Text("Error: $e"),
                  loading: () => const CircularProgressIndicator())),
          TextButton(
              onPressed: isLoading ? null : viewController.logout,
              child: Text("Logout"))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: isLoading ? null : viewController.getRandomNumber,
        backgroundColor: isLoading ? Color.fromRGBO(0, 0, 0, 0.61) : Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }
}
