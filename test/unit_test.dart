import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_mvcs_counter/controllers/auth_controller.dart';
import 'package:riverpod_mvcs_counter/controllers/random_number_controller.dart';
import 'package:riverpod_mvcs_counter/models/user.dart';
import 'package:riverpod_mvcs_counter/models/random_number.dart';
import 'package:riverpod_mvcs_counter/services/auth_service.dart';
import 'package:riverpod_mvcs_counter/services/random_number_service.dart';
import 'package:riverpod_mvcs_counter/views/auth/auth_view_controller.dart';
import 'package:riverpod_mvcs_counter/views/random_number/random_number_view_controller.dart';

class FakeNumberService implements NumberService {
  Future<int> getRandomNumber() async {
    await Future.delayed(Duration(seconds: 1));
    return 1;
  }
}

void main() {
  test('Random Number Model Test', () async {
    final container = ProviderContainer();
    expect(container.read(randomNumberModel), AsyncData(0));
    container.read(randomNumberModel.notifier).setCount(1);
    expect(container.read(randomNumberModel), AsyncData(1));
  });

  test('Random Number Controller Test', () async {
    final container = ProviderContainer(
        overrides: [numberService.overrideWithValue(FakeNumberService())]);
    expect(container.read(randomNumberModel), AsyncData(0));
    expect(await container.read(randomNumberController).getRandomNumber(), 1);
    expect(container.read(randomNumberModel), AsyncData(1));
  });

  test('Number Service Test', () async {
    final container = ProviderContainer(
        overrides: [numberService.overrideWithValue(FakeNumberService())]);

    expect(await container.read(numberService).getRandomNumber(), 1);
  });

  test('Random Number View Controller Test', () async {
    final container = ProviderContainer(
        overrides: [numberService.overrideWithValue(FakeNumberService())]);

    expect(container.read(randomNumberViewController), false);
    container.read(randomNumberViewController.notifier).getRandomNumber();
    expect(container.read(randomNumberViewController), true);
    await Future.delayed(Duration(seconds: 1));
    expect(container.read(randomNumberViewController), false);
    container.read(randomNumberViewController.notifier).logout();
    expect(container.read(randomNumberViewController), true);
    await Future.delayed(Duration(seconds: 1));
    expect(container.read(randomNumberViewController), false);
  });

  test('App Model Test', () async {
    final container = ProviderContainer();
    expect(container.read(user), AsyncData(''));
    container.read(user.notifier).setCurrentUser("jpoh4869");
    expect(container.read(user), AsyncData('jpoh4869'));
  });

  test('Auth Controller Test', () async {
    final container = ProviderContainer();
    expect(container.read(user), AsyncData(''));
    expect(await container.read(authController).login(), 'jpoh4869');
    expect(container.read(user), AsyncData('jpoh4869'));
    expect(await container.read(authController).logout(), '');
    expect(container.read(user), AsyncData(''));
  });

  test('Auth Service Test', () async {
    final container = ProviderContainer(
        overrides: [numberService.overrideWithValue(FakeNumberService())]);

    expect(await container.read(authService).login(), 'jpoh4869');
    expect(await container.read(authService).logout(), '');
  });

  test('Auth View Controller Test', () async {
    final container = ProviderContainer(
        overrides: [numberService.overrideWithValue(FakeNumberService())]);

    expect(container.read(authViewController), false);
    container.read(authViewController.notifier).login();
    expect(container.read(authViewController), true);
    await Future.delayed(Duration(seconds: 1));
    expect(container.read(authViewController), false);
  });
}
