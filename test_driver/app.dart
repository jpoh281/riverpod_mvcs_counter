import 'package:flutter_driver/driver_extension.dart';
import 'package:riverpod_mvcs_counter/main.dart' as app;

void main() {
  // Extension을 활성화합니다.
  enableFlutterDriverExtension();

  // 앱의 `main()` 함수를 호출하거나 테스트하고 싶은 위젯을 인자로 넣어 `runApp`을
  // 호출합니다.
  app.main();
}