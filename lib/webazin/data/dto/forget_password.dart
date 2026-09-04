import 'dart:convert';


class DataForgetPassword {
  DataForgetPassword({
    this.email,
  });

  final String? email;

  factory DataForgetPassword.fromJson(String str) => DataForgetPassword.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DataForgetPassword.fromMap(Map<String, dynamic> json) => DataForgetPassword(
    email: json["email"] == null ? null : json["email"],
  );

  Map<String, dynamic> toMap() => {
    "email": email == null ? null : email,
  };
}
