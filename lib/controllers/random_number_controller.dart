import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_mvcs_counter/models/random_number.dart';
import 'package:riverpod_mvcs_counter/services/random_number_service.dart';

final randomNumberController =
    Provider<RandomNumberController>((ref) => RandomNumberController(ref.read));

class RandomNumberController {
  final Reader _read;

  RandomNumberController(this._read);

  Future<int> getRandomNumber() async {
    int randomNumber = await _read(numberService).getRandomNumber();
    _read(randomNumberModel.notifier).setCount(randomNumber);

    return randomNumber;
  }
}
