

import 'package:chat_app/core/models/api_models.dart';

import 'api.dart';

class FakeApi implements Api {
  @override
  Future<List<Comment>> getCommentsForPost(int postId) async {
    await Future.delayed(Duration(seconds: 4));

    if (postId == 1) {
      return List<Comment>.generate(10, (index) => Comment(body: 'bla bla🍉'));
    }

    return null;
  }

  @override
  Future<List<Post>> getPostsForUser(int userId) async {
    await Future.delayed(Duration(seconds: 1));

    if (userId == 1) {
      return List<Post>.generate(10, (index) => Post());
    }

    if (userId == 2) {
      return List<Post>();
    }

    return null;
  }

  @override
  Future<User> getUser(int userId) async {
    await Future.delayed(Duration(seconds: 1));

    if (userId == 1) {
      return User(name: 'dane', phoneNumber: '999-999-00');
    }

    if (userId == 2) {
      return User(name: 'Flutter', phoneNumber: '737-000-93');
    }

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

  Future <List<Doctor>> getDoctors()async{
    await Future.delayed(Duration(seconds: 2));
    return [
      Doctor(
         title: "doctor of nursery",
        rank: 5,
        name: "ahmed",
        price: 5,
        distnaceAway: 6.6
      ),
      Doctor(
          title: "doctor of nursery",
          rank: 5,
          name: "ahmed",
          price: 5,
          distnaceAway: 6.6
      ), Doctor(
          title: "doctor of nursery",
          rank: 5,
          name: "ahmed",
          price: 5,
          distnaceAway: 6.6
      ),
    ];
  }
}
