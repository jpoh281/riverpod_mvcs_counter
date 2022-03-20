import 'package:flutter_riverpod/flutter_riverpod.dart';

// todo: AsyncValue의 Loading 사용해보기
final user = StateNotifierProvider<User, AsyncValue<String>>((ref) => User());

class User extends StateNotifier<AsyncValue<String>> {
  User() : super(AsyncData(""));

  setCurrentUser(String currentUser) {
    state = AsyncData(currentUser);
  }
}
