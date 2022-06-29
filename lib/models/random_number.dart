import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final randomNumberModel =
    StateNotifierProvider.autoDispose<RandomNumberModel, AsyncValue<int>>(
        (ref) => RandomNumberModel());

class RandomNumberModel extends StateNotifier<AsyncValue<int>> {
  RandomNumberModel() : super(const AsyncLoading());

  void setLoading() {
    state = const AsyncLoading();
  }

  void setCount(int number) {
    state = AsyncData(number);
  }

  void setError(Exception error) {
    state = AsyncError(error);
  }

  @override
  void dispose() {
    log("dispose", name:"");
    super.dispose();
  }
}
