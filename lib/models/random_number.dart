import 'package:flutter_riverpod/flutter_riverpod.dart';

final randomNumberModel = StateNotifierProvider.autoDispose<RandomNumberModel, int>((ref) => RandomNumberModel());

class RandomNumberModel extends StateNotifier<int> {
  RandomNumberModel() : super(0);

  setCount(int number){
    state = number;
  }
}
