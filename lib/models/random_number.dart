import 'package:flutter_riverpod/flutter_riverpod.dart';

final randomNumberModel =
    StateNotifierProvider.autoDispose<RandomNumberModel, AsyncValue<int>>(
        (ref) => RandomNumberModel());

class RandomNumberModel extends StateNotifier<AsyncValue<int>> {
  RandomNumberModel() : super(const AsyncData(0));

  void setLoading(){
    state = const AsyncLoading();
  }

  void setCount(int number) {
    state = AsyncData(number);
  }

  void setError(Exception error){
    state = AsyncError(error);
  }
}
