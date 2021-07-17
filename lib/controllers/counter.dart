import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_mvcs_counter/models/count.dart';
import 'package:riverpod_mvcs_counter/services/random_number_service.dart';


final counterController = Provider<Counter>((ref) => Counter(ref.read));
class Counter {
  final Reader _read;

  Counter(this._read);

  Future<void> getRandomNumber() async {
    int number = await _read(numberService).call();
    _read(countProvider.notifier).setCount(number);
  }
}