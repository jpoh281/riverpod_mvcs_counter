import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_mvcs_counter/models/user.dart';
import 'package:riverpod_mvcs_counter/services/auth_service.dart';

final authController =
    Provider<RandomNumberController>((ref) => RandomNumberController(ref.read));

class RandomNumberController {
  final Reader _read;

  RandomNumberController(this._read);

  Future<String> login() async {
    String currentUser = await _read(authService).login();
    _read(user.notifier).setCurrentUser(currentUser);
    return currentUser;
  }

  Future<String> logout() async {
    String currentUser = await _read(authService).logout();
    _read(user.notifier).setCurrentUser(currentUser);
    return currentUser;
  }
}
