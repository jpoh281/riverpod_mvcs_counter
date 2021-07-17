import 'package:flutter_riverpod/flutter_riverpod.dart';

final randomNumber = StateNotifierProvider<RandomNumber, int>((ref) => RandomNumber());

class RandomNumber extends StateNotifier<int> {
  RandomNumber() : super(0);

  setCount(int number){
    state = number;
  }
}
