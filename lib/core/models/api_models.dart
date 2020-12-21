import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String name;
  final String id;
  final String email;
  final String phone;

  User({this.name, this.email, this.id, this.phone});

  User.fromDocumentSnapshot(DocumentSnapshot snapshot)
      : id = snapshot.id,
        name = (snapshot != null && snapshot["name"] != null) ? snapshot["name"] : "",
        phone = (snapshot != null && snapshot["phone"] != null) ? snapshot["phone"] : "",
        email = (snapshot != null && snapshot["email"] != null) ? snapshot["email"] : "";

  factory User.fromMap(Map<String, dynamic> map) {
    return User(name: map['name'], email: map['email'],phone: map['phone']);
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
