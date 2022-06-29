import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_mvcs_counter/models/random_number.dart';
import 'package:riverpod_mvcs_counter/services/random_number_service.dart';

final randomNumberController =
    Provider<RandomNumberController>((ref) => RandomNumberController(ref));

class RandomNumberController {
  final Ref _ref;

  RandomNumberController(this._ref);

  Future<int> getRandomNumber() async {
    var model = _ref.read(randomNumberModel.notifier);
    model.setLoading();
    try {
      int randomNumber = await _ref.read(numberService).getRandomNumber();
      model.setCount(randomNumber);
      return randomNumber;
    } catch (e) {
      model.setError(e as Exception);
      return -1;
    }
  }
}
