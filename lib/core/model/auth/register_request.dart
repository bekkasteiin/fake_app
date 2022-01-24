// To parse this JSON data, do
//
//     final registerRequest = registerRequestFromMap(jsonString);

import 'dart:convert';

class RegisterRequest {
  RegisterRequest({
    this.phoneNumbers
  });

  List<PhoneNumber> phoneNumbers;

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
    'phoneNumbers': phoneNumbers == null ? null : List<dynamic>.from(phoneNumbers.map((x) => x.toMap()))};
}

class PhoneNumber {
  PhoneNumber({
    this.phone,
  });

  String phone;

  factory PhoneNumber.fromJson(String str) => PhoneNumber.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PhoneNumber.fromMap(Map<String, dynamic> json) => PhoneNumber(
    phone: json['phone'],
  );

  Map<String, dynamic> toMap() => {
    'phone': phone,
  };
}
