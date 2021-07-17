import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_mvcs_counter/controllers/counter.dart';


final counterViewController = StateNotifierProvider<CounterViewController, bool>((ref) {
  return CounterViewController(ref.read);
});

class CounterViewController extends StateNotifier<bool>{

  CounterViewController(this._read) : super(false);

  Reader _read;

  getRandomNumber() async {
    state = true;
    await _read(counterController).getRandomNumber();
    state = false;
  }
}