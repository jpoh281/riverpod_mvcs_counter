// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:riverpod_mvcs_counter/main.dart';
import 'package:riverpod_mvcs_counter/models/user.dart';
import 'package:riverpod_mvcs_counter/services/random_number_service.dart';
import 'package:riverpod_mvcs_counter/views/random_number/random_number_view.dart';

const kDisableColor = Color.fromRGBO(0, 0, 0, 0.61);

class FakeNumberService implements NumberService {
  Future<int> getRandomNumber() async {
    // Fake a service call, and return random number
    await Future.delayed(Duration(seconds: 1));
    return 1;
  }
}

class FakeAppModel extends StateNotifier<AsyncValue<String>> implements User {
  FakeAppModel() : super(AsyncData("jpoh4869"));

  setCurrentUser(String currentUser) {
    state = AsyncData(currentUser);
  }
}

void main() {
  testWidgets('RandomNumberView(FloatingActionButton)',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(ProviderScope(
      child: MaterialApp(
        home: RandomNumberView(),
      ),
      overrides: [
        numberService.overrideWithValue(FakeNumberService()),
      ],
    ));

    // init value is Random Number : 0
    expect(find.text('Random Number : 0'), findsOneWidget);
    expect(find.text('Random Number : 1'), findsNothing);
    expect(find.byType(CircularProgressIndicator), findsNothing);

    await tester.tap(find.byIcon(Icons.add));

    // after Tab UI has Two CircularProgressIndicator
    await tester.pump();
    expect(find.text('Random Number : 0'), findsOneWidget);
    expect(find.text('Random Number : 1'), findsNothing);

    _expectIsLoading(tester);

    // finish value is Rnadom Number : 1
    await tester.pump(Duration(seconds: 1));
    expect(find.text('Random Number : 0'), findsNothing);
    expect(find.text('Random Number : 1'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('RandomNumberView(Logout)', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(ProviderScope(
      child: MyApp(),
      overrides: [
        numberService.overrideWithValue(FakeNumberService()),
        user.overrideWithValue(FakeAppModel())
      ],
    ));

    // init value is Random Number : 0
    expect(find.text('Hello, jpoh4869'), findsOneWidget);
    expect(find.text('Random Number : 0'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);

    await tester.tap(find.text('Logout'));

    // after Tab UI has Two CircularProgressIndicator
    await tester.pump();
    expect(find.text('Random Number : 0'), findsOneWidget);

    _expectIsLoading(tester);

    // finish value is Rnadom Number : 1
    await tester.pump(Duration(seconds: 1));
    expect(find.text("Login"), findsOneWidget);
  });

  testWidgets('Auth View(Text Button)', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(ProviderScope(
      child: MyApp(),
      overrides: [numberService.overrideWithValue(FakeNumberService())],
    ));

    // init value is Random Number : 0
    expect(find.text('Random Number : 0'), findsNothing);
    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.text("Login"), findsOneWidget);

    await tester.tap(find.text("Login"));

    // after Tab UI has Two CircularProgressIndicator
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text("Login"), findsNothing);
    // finish value is Rnadom Number : 1

    await tester.pump(Duration(seconds: 1));
    expect(find.text('Hello, jpoh4869'), findsOneWidget);
    expect(find.text('Random Number : 0'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });
}

_expectIsLoading(WidgetTester tester) {
  final textButton =
      tester.widget<TextButton>(find.widgetWithText(TextButton, "Logout"));
  expect(textButton.onPressed, null);

  final fabButton = tester.widget<FloatingActionButton>(
      find.widgetWithIcon(FloatingActionButton, Icons.add));
  expect(fabButton.onPressed, null);
  expect(fabButton.backgroundColor, Color.fromRGBO(0, 0, 0, 0.61));
}
