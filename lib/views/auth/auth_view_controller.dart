import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_mvcs_counter/controllers/auth_controller.dart';

final authViewController =
StateNotifierProvider<AuthViewController, bool>((ref) {
  return AuthViewController(ref.read);
});

class AuthViewController extends StateNotifier<bool> {
  AuthViewController(this._read) : super(false);

  Reader _read;

  login() async {
    state = true;
    await _read(authController).login();
    state = false;
  }
}
