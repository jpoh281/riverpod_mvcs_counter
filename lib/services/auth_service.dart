import 'package:flutter_riverpod/flutter_riverpod.dart';

final authService = Provider<AuthService>((ref) {
  return AuthService();
});

class AuthService {

  Future<String> login() async{
    await Future.delayed(Duration(seconds: 1));
    return 'jpoh4869';
  }

  Future<String> logout() async{
    await Future.delayed(Duration(seconds: 1));
    return '';
  }
}


