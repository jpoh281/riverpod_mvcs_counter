import 'package:flutter_riverpod/flutter_riverpod.dart';

final user = StateNotifierProvider<User, AsyncValue<String>>((ref) => User());

class User extends StateNotifier<AsyncValue<String>> {
  User() : super(AsyncData(""));

  setCurrentUser(String currentUser) {
    state = AsyncData(currentUser);
  }
}
