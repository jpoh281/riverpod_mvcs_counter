import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:riverpod_mvcs_counter/main.dart';
import 'package:riverpod_mvcs_counter/services/random_number_service.dart';

class FakeNumberService implements NumberService {
  Future<int> getRandomNumber() async {
    // Fake a service call, and return random number
    await Future.delayed(Duration(seconds: 1));
    return 1;
  }
}

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();

  testWidgets('login -> getRandomNumber -> logout',
      (WidgetTester tester) async {
    await tester.pumpWidget(ProviderScope(
      child: MyApp(),
      overrides: [numberService.overrideWithValue(FakeNumberService())],
    ));
    await tester.pumpAndSettle(); // Finish animations and scheduled microtasks
    await tester.pump(Duration(seconds: 2)); // Render another frame in 2s

    expect(find.text("Login"),findsOneWidget);

    await tester.tap(find.text("Login"));

    // after Tab UI has Two CircularProgressIndicator
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pumpAndSettle(Duration(seconds: 1));
    expect(find.text('Hello, jpoh4869'), findsOneWidget);
    expect(find.text('Random Number : 0'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    _expectIsLoading(tester);

    await tester.pumpAndSettle(Duration(seconds: 1));
    expect(find.text('Random Number : 0'), findsNothing);
    expect(find.text('Random Number : 1'), findsOneWidget);

    await tester.tap(find.text('Logout'));
    await tester.pump();

    _expectIsLoading(tester);

    await tester.pumpAndSettle(Duration(seconds: 1));
    expect(find.text("Login"),findsOneWidget);
  });
}


_expectIsLoading(WidgetTester tester){
  final textButton =
  tester.widget<TextButton>(find.widgetWithText(TextButton, "Logout"));
  expect(textButton.onPressed, null);

  final fabButton = tester.widget<FloatingActionButton>(
      find.widgetWithIcon(FloatingActionButton, Icons.add));
  expect(fabButton.onPressed, null);
  expect(fabButton.backgroundColor, Color.fromRGBO(0, 0, 0, 0.61));
}