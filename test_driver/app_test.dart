import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';


void main() {
  group('Counter App', () {
    // 먼저 Finders를 정의합니다. 테스트 모음의 위젯들을 위치시키기 위해 Finder를
    // 사용할 것입니다. 참고: `byValueKey` 메서드에 인자로 넘겨줄 문자열은 step 1에서
    // 사용한 Key와 동일해야 합니다.
    // final loginButton = find.text('Login');
    // final buttonFinder = find.byValueKey('increment');

    late FlutterDriver driver;

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      driver.close();
    });

    // test('starts at 0', () async {
    //   // Use the `driver.getText` method to verify the counter starts at 0.
    //   expect(loginButton, fl_test.findsOneWidget);
    // });

  });
}
