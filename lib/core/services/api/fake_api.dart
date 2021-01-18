

import 'package:chat_app/core/models/api_models.dart';

import 'api.dart';

class FakeApi implements Api {

  @override
  Future<UserModel> getUser(int userId) async {
    await Future.delayed(Duration(seconds: 1));

    // if (userId == 1) {
    //   return User(name: 'dane', phoneNumber: '999-999-00');
    // }
    //
    // if (userId == 2) {
    //   return User(name: 'Flutter', phoneNumber: '737-000-93');
    // }

    return null;
  }

  @override
  Future<LoginResponse> login({String username, String password}) async {
    await Future.delayed(Duration(seconds: 1));

    if (username == 'dane') {
      return LoginResponse(userId: 1);
    }

    if (username == 'flutter') {
      return LoginResponse(userId: 2);
    }

    return LoginResponse(success: false, message: 'Username not found');
  }

}
