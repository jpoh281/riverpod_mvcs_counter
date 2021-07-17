import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_mvcs_counter/models/random_number.dart';
import 'package:riverpod_mvcs_counter/views/random_number/random_number_view_controller.dart';

class RandomNumberView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isLoading = ref.watch(randomNumberViewController);
    int number = ref.watch(randomNumber);
    var viewController = ref.watch(randomNumberViewController.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text("Riverpod MVC + S"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: isLoading
                  ? CircularProgressIndicator()
                  : Text("Random Number : $number"))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => isLoading ? null : viewController.getRandomNumber(),
        child: isLoading
            ? CircularProgressIndicator(
                color: Colors.white,
              )
            : Icon(Icons.add),
      ),
    );
  }
}
