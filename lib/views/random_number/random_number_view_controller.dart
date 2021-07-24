import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_mvcs_counter/controllers/auth_controller.dart';
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

  logout() async{
    state = true;
    await _read(authController).logout();
    state = false;
  }
}
