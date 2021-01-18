import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String name;
  final String id;
  final String email;
  final String phone;

  UserModel({this.name, this.email, this.id, this.phone});

  UserModel.fromDocumentSnapshot(DocumentSnapshot snapshot)
      : id = snapshot.id,
        name = (snapshot != null && snapshot["name"] != null) ? snapshot["name"] : "",
        phone = (snapshot != null && snapshot["phone"] != null) ? snapshot["phone"] : "",
        email = (snapshot != null && snapshot["email"] != null) ? snapshot["email"] : "";

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(name: map['name'], email: map['email'], phone: map['phone']);
  }

  toMap() {
    return {"name": name, "email": email, "id": id, "phone": phone};
  }
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

class UserDetail {
  final String id;
  final String userId;
  final String name;
  final String image;

  UserDetail({this.id, this.name, this.image, this.userId});

  UserDetail.fromDocumentSnapshot(DocumentSnapshot snapshot)
      : id = snapshot.id,
        userId = (snapshot != null && snapshot["userId"] != null) ? snapshot["UserId"] : "",
        name = (snapshot != null && snapshot["name"] != null) ? snapshot["name"] : "",
        image = (snapshot != null && snapshot["image"] != null) ? snapshot["image"] : "";

  factory UserDetail.fromMap(Map<String, dynamic> map) {
    return UserDetail(userId: map['userId'], image: map['image'], name: map['name'], id: map["id"]);
  }

  toMap() {
    return {"name": name, "userId": userId, "id": id, "image": image};
  }
}

class MessageModel {
  final String id;
  final Timestamp time;
  final String text;
  final bool isNew;

  MessageModel({this.text, this.isNew, this.time, this.id});

  MessageModel.fromDocumentSnapshot(DocumentSnapshot snapshot)
      : id = snapshot.id,
        time = (snapshot != null && snapshot["time"] != null) ? snapshot["time"] : "",
        text = (snapshot != null && snapshot["text"] != null) ? snapshot["text"] : "",
        isNew = (snapshot != null && snapshot["isNew"] != null) ? snapshot["isNew"] : "";

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(time: map['time'], text: map['text'], isNew: map['isNew'], id: map["id"]);
  }

  toMap() {
    return {"time": time, "text": text, "id": id, "isNew": isNew};
  }
}

class ChatModel {
  final String id;
  final List<UserModel> users;
  final List<MessageModel> messages;

  ChatModel({this.users, this.messages, this.id});

  ChatModel.fromDocumentSnapshot(DocumentSnapshot snapshot)
      : id = snapshot.id,
        users = (snapshot != null && snapshot["users"] != null) ? snapshot["users"].values .toList(): "",
        messages = (snapshot != null && snapshot["messages"] != null) ? snapshot["messages"].values.toList()  : "";

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(messages: map['messages'], users: map['users'], id: map["id"]);
  }

  toMap() {
    return {"users": users, "messages": messages, "id": id};
  }

}
