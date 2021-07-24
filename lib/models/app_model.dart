import 'package:flutter_riverpod/flutter_riverpod.dart';

final appModel = StateNotifierProvider<AppModel, String>((ref) => AppModel());

class AppModel extends StateNotifier<String>{
  AppModel():super("");

  setCurrentUser(String currentUser){
    state = currentUser;
  }
}