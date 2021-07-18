# riverpod_mvcs_counter

Riverpod MVCS Example App (Random Number App)

## Model
```
import 'package:flutter_riverpod/flutter_riverpod.dart';

final randomNumber = StateNotifierProvider<RandomNumber, int>((ref) => RandomNumber());

class RandomNumber extends StateNotifier<int> {
  RandomNumber() : super(0);

  setCount(int number){
    state = number;
  }
}
```

## Service
```
import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final numberService = Provider<NumberService>((ref) {
  return NumberService();
});

class NumberService {
  Future<int> getRandomNumber() async {
    // Fake a service call, and return random number
    await Future.delayed(Duration(seconds: 1));
    return Random().nextInt(999);
  }
}
```

## Controller
```
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_mvcs_counter/models/random_number.dart';
import 'package:riverpod_mvcs_counter/services/random_number_service.dart';

final randomNumberController =
    Provider<RandomNumberController>((ref) => RandomNumberController(ref.read));

class RandomNumberController {
  final Reader _read;

  RandomNumberController(this._read);

  Future<void> getRandomNumber() async {
    int number = await _read(numberService).getRandomNumber();
    _read(randomNumber.notifier).setCount(number);
  }
}
```

## View & View Controller
```
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_mvcs_counter/models/random_number.dart';
import 'package:riverpod_mvcs_counter/views/random_number/random_number_view_controller.dart';

class RandomNumberView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isLoading = ref.watch(randomNumberViewController);
    var viewController =     ref.watch(randomNumberViewController.notifier);

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
                  : Text("Random Number : ${ref.watch(randomNumber)}"))
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
```

```
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_mvcs_counter/controllers/random_number_controller.dart';

final randomNumberViewController =
    StateNotifierProvider<RandomNumberViewController, bool>((ref) {
  return RandomNumberViewController(ref.read);
});

class RandomNumberViewController extends StateNotifier<bool> {
  RandomNumberViewController(this._read) : super(false);

  Reader _read;

  getRandomNumber() async {
    state = true;
    await _read(randomNumberController).getRandomNumber();
    state = false;
  }
}
```

![KakaoTalk_Photo_2021-07-18-03-13-34](https://user-images.githubusercontent.com/54665433/126060051-a94cb44c-4426-47d7-8f74-795ad7af8705.gif)

