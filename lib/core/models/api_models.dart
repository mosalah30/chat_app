
class Post {
  final int id;
  final String body;

  Post({this.body, this.id});
}

class Comment {
  final String body;

  Comment({this.body});
}

class User {
  final String name;
  final String phoneNumber;
  final String token;

  User({
    this.name,
    this.token,
    this.phoneNumber,
  });

  toJson() {
    ////TODO  implementation
  }

  static User fromJson(decode) {}
}

class LoginResponse {
  final bool success;
  final int userId;
  final String message;

  LoginResponse({
    this.success = true,
    this.userId,
    this.message,
  });
}

class Doctor {
  String id;
  String imgUrl;
  String name;
  String title;
  num rank;
  num distnaceAway;
  num price;
  String location;
  String availibiltyTime;
  String timeSchedule;
  Doctor(
      {this.title,
      this.id,
      this.location,
      this.name,
      this.rank,
      this.imgUrl,
      this.price,
      this.availibiltyTime,
      this.distnaceAway,
      this.timeSchedule});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "id": id,
      "title": title,
      "name": name,
      "location": location,
      "rank": rank,
      "imgUrl": imgUrl,
      "price": price,
      "availibiltyTime": availibiltyTime,
      "distanceAway": distnaceAway,
      "timeSchedule": timeSchedule
    };
    return map;
  }

//  fromJson(Map<String, dynamic> map) {
//    id = map["id"];
//
//  }
}
