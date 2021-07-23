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
import 'package:riverpod_mvcs_counter/services/random_number_service.dart';

class FakeNumberService implements NumberService {
  Future<int> getRandomNumber() async {
    // Fake a service call, and return random number
    await Future.delayed(Duration(seconds: 1));
    return 1;
  }
}

void main() {
  testWidgets('get Random Number Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(ProviderScope(
      child: MyApp(),
      overrides: [numberService.overrideWithValue(FakeNumberService())],
    ));

    // init value is Random Number : 0
    expect(find.text('Random Number : 0'), findsOneWidget);
    expect(find.text('Random Number : 1'), findsNothing);
    expect(find.byType(CircularProgressIndicator), findsNothing);

    await tester.tap(find.byIcon(Icons.add));

    // after Tab UI has Two CircularProgressIndicator
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsNWidgets(2));
    expect(find.text('Random Number : 0'), findsNothing);
    expect(find.text('Random Number : 1'), findsNothing);

    // finish value is Rnadom Number : 1
    await tester.pump(Duration(seconds: 1));
    expect(find.text('Random Number : 0'), findsNothing);
    expect(find.text('Random Number : 1'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);

  });
}
