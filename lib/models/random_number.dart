import 'package:flutter_riverpod/flutter_riverpod.dart';

// todo: AsyncValue의 Loading 사용해보기
final randomNumberModel =
    StateNotifierProvider<RandomNumberModel, AsyncValue<int>>(
        (ref) => RandomNumberModel());

class RandomNumberModel extends StateNotifier<AsyncValue<int>> {
  RandomNumberModel() : super(AsyncData(0));

  setCount(int number) {
    state = AsyncData(number);
  }
}
