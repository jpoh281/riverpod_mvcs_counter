import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final numberService = Provider<NumberService>((ref) {
  return NumberService();
});

class NumberService {
  Future<int> getRandomNumber() async {
    // Fake a service call, and return random number
    await Future.delayed(Duration(seconds: 1));
    return Random().nextInt(999);
  }
}
