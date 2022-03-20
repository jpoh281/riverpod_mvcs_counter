import 'package:flutter_riverpod/flutter_riverpod.dart';

final randomNumberModel =
    StateNotifierProvider.autoDispose<RandomNumberModel, AsyncValue<int>>(
        (ref) => RandomNumberModel());

class RandomNumberModel extends StateNotifier<AsyncValue<int>> {
  RandomNumberModel() : super(AsyncData(0));

  setLoading(){
    state = AsyncLoading();
  }

  setCount(int number) {
    state = AsyncData(number);
  }

  setError(Exception error){
    state = AsyncError(error);
  }
}
