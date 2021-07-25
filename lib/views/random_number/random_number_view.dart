import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_mvcs_counter/models/app_model.dart';
import 'package:riverpod_mvcs_counter/models/random_number.dart';
import 'package:riverpod_mvcs_counter/views/random_number/random_number_view_controller.dart';

class RandomNumberView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isLoading = ref.watch(randomNumberViewController);
    int number = ref.watch(randomNumberModel);
    String currentUser = ref.watch(appModel);
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
              child: isLoading
                  ? const CircularProgressIndicator()
                  : Text("Random Number : $number")),
          TextButton(
              onPressed: viewController.logout,
              child: isLoading
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : Text("Logout"))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => isLoading ? null : viewController.getRandomNumber(),
        child: isLoading
            ? const CircularProgressIndicator(
                color: Colors.white,
              )
            : const Icon(Icons.add),
      ),
    );
  }
}
