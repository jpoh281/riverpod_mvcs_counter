import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_mvcs_counter/models/random_number.dart';
import 'package:riverpod_mvcs_counter/models/user.dart';
import 'package:riverpod_mvcs_counter/views/random_number/random_number_view_controller.dart';

class RandomNumberView extends ConsumerWidget {
  const RandomNumberView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isLoading = ref.watch(randomNumberViewController);
    var currentUser = ref.watch(user).unwrapPrevious();
    var viewController = ref.watch(randomNumberViewController.notifier);
    return Scaffold(
      appBar: AppBar(
        key: const ValueKey('RandomNumberView Appbar'),
        title: currentUser.when(
          data: (userName) => Text("Hello, $userName"),
          error: (e, s) => const Text(""),
          loading: () => const Text(""),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ref.watch(randomNumberModel).unwrapPrevious().when(
                  data: (data) {
                    return Text("Random Number : $data");
                  },
                  error: (e, s) => Text("Error: $e"),
                  loading: () => const CircularProgressIndicator(),
                ),
          ),
          TextButton(
            onPressed: isLoading ? null : viewController.logout,
            child: const Text("Logout"),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: isLoading ? null : viewController.getRandomNumber,
        backgroundColor:
            isLoading ? const Color.fromRGBO(0, 0, 0, 0.61) : Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }
}
