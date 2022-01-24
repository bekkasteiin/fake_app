import 'dart:convert';

class RegisterResponseData {
  RegisterResponseData(
      {this.success,
      this.user,
      this.message,
      this.dataTime,
      this.password,
      this.requestedPhone});

  bool success;
  DateTime dataTime;
  String user;
  String password;
  String message;
  String requestedPhone;

  factory RegisterResponseData.fromJson(String str) =>
      RegisterResponseData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RegisterResponseData.fromMap(Map<String, dynamic> json) =>
      RegisterResponseData(
          success: json["success"] == null ? null : json["success"],
          // dataTime: json["dataTime"] == null ? null : DateTime.parse(json["dataTime"]),
          user: json["user"] == null ? null : json["user"],
          password: json["password"] == null ? null : json["password"],
          message: json["message"] == null ? null : json["message"],
          requestedPhone:
              json["requestedPhone"] == null ? null : json["requestedPhone"]);

  Map<String, dynamic> toMap() => {
        'success': success,
        'dataTime': dataTime,
        'user': user,
        'password': password,
        'message': message,
        'requestedPhone': requestedPhone,
      };
}
