import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_mvcs_counter/controllers/random_number_controller.dart';
import 'package:riverpod_mvcs_counter/models/random_number.dart';
import 'package:riverpod_mvcs_counter/services/random_number_service.dart';
import 'package:riverpod_mvcs_counter/views/random_number/random_number_view_controller.dart';

class FakeNumberService implements NumberService {
  Future<int> getRandomNumber() async {
    // Fake a service call, and return random number
    await Future.delayed(Duration(seconds: 1));
    return 1;
  }
}

void main() {
  test('Random Number Model Test', () async{
    final container = ProviderContainer(
      overrides: [
        numberService.overrideWithValue(FakeNumberService())
      ]
    );

    int model = container.read(randomNumber);
    expect(model, 0);
    await container.read(randomNumberController).getRandomNumber();
    model = container.read(randomNumber);
    expect(model, 1);
  });

  test('Number Service Test', () async{
    final container = ProviderContainer(
        overrides: [
          numberService.overrideWithValue(FakeNumberService())
        ]
    );

    expect(await container.read(numberService).getRandomNumber(), 1);
  });

  test('Random Number View Controller Test', () async{
    final container = ProviderContainer(
        overrides: [
          numberService.overrideWithValue(FakeNumberService())
        ]
    );

    expect(container.read(randomNumberViewController), false);
    container.read(randomNumberViewController.notifier).getRandomNumber();
    expect(container.read(randomNumberViewController), true);
    await  Future.delayed(Duration(seconds: 1));
    expect(container.read(randomNumberViewController), false);
  });
}