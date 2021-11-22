import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.token,
    required this.user,
  });

  String? token;
  UserClass user;

  factory User.fromJson(Map<String, dynamic> json) => User(
    token: json["token"],
    user: UserClass.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "token": token,
    "user": user.toJson(),
  };
}

class UserClass {
  UserClass({
     this.id,
     this.name,
     this.email,
  });

  String? id;
  String? name;
  String? email;

  factory UserClass.fromJson(Map<String, dynamic> json) => UserClass(
    id: json["id"],
    name: json["name"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
  };
}