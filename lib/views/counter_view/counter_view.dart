import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_mvcs_counter/models/count.dart';
import 'package:riverpod_mvcs_counter/views/counter_view/counter_view_controller.dart';

class CounterView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    bool isLoading = ref.watch(counterViewController);
    var viewController = ref.watch(counterViewController.notifier);

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
                  : Text("Random Number : ${ref.watch(countProvider)}"))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>isLoading ? null : viewController.getRandomNumber(),
        child: isLoading ? CircularProgressIndicator(color: Colors.white,) : Icon(Icons.add),
      ),
    );
  }
}
