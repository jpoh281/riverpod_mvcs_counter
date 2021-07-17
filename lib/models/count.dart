import 'package:flutter_riverpod/flutter_riverpod.dart';

final countProvider = StateNotifierProvider<Count, int>((ref) => Count());

class Count extends StateNotifier<int> {
  Count() : super(0);

  setCount(int number){
    state = number;
  }
}
