import 'dart:convert';

UserInfo userInfoFromJson(String str) => UserInfo.fromMap(json.decode(str));

String userInfoToJson(UserInfo data) => json.encode(data.toMap());

class UserInfo {
  String id;
  String login;
  String name;
  String password;
  String pin;
  String firstName;
  String middleName;
  String lastName;
  String position;
  String email;
  String timeZone;
  String language;
  String instanceName;
  String locale;

  UserInfo(
      {this.id,
      this.login,
      this.name,
      this.firstName,
      this.middleName,
      this.lastName,
      this.position,
      this.email,
      this.timeZone,
      this.language,
      this.instanceName,
      this.locale,
      this.password,
      this.pin});

  factory UserInfo.fromMap(Map<String, dynamic> json) => UserInfo(
        id: json["id"] == null ? null : json["id"],
        login: json["login"] == null ? null : json["login"],
        name: json["name"] == null ? null : json["name"],
        firstName: json["firstName"] == null ? null : json["firstName"],
        middleName: json["middleName"] == null ? null : json["middleName"],
        lastName: json["lastName"] == null ? null : json["lastName"],
        position: json["position"] == null ? null : json["position"],
        email: json["email"] == null ? null : json["email"],
        timeZone: json["timeZone"] == null ? null : json["timeZone"],
        language: json["language"] == null ? null : json["language"],
        instanceName:
            json["_instanceName"] == null ? null : json["_instanceName"],
        locale: json["locale"] == null ? null : json["locale"],
        password: json["password"] == null ? null : json["password"],
        pin: json["pin"] == null ? null : json["pin"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "login": login == null ? null : login,
        "name": name == null ? null : name,
        "firstName": firstName == null ? null : firstName,
        "middleName": middleName == null ? null : middleName,
        "lastName": lastName == null ? null : lastName,
        "position": position == null ? null : position,
        "email": email == null ? null : email,
        "timeZone": timeZone == null ? null : timeZone,
        "language": language == null ? null : language,
        "_instanceName": instanceName == null ? null : instanceName,
        "locale": locale == null ? null : locale,
        "password": password == null ? null : password,
        "pin": pin == null ? null : pin,
      };
}
