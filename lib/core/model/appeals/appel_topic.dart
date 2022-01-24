import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:hse/viewmodels/user_info.dart';
import 'package:provider/provider.dart';

class AppealTopic {
  AppealTopic({
    this.code,
    this.nameRu,
    this.nameKz,
    this.nameEn,
  });

  String code;
  String nameRu;
  String nameKz;
  String nameEn;

  String getName(BuildContext context) {
    var user = Provider.of<UserInfoModel>(context);
    if (user.localeCode == 'kk' && nameKz != null && nameKz.isNotEmpty) {
      return nameKz;
    }
    if (user.localeCode == 'ru' && nameRu != null && nameRu.isNotEmpty) {
      return nameRu;
    }
    if (user.localeCode == 'en' && nameEn != null && nameEn.isNotEmpty) {
      return nameEn;
    }
    return nameRu;
  }

  factory AppealTopic.fromJson(String str) =>
      AppealTopic.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AppealTopic.fromMap(Map<String, dynamic> json) => AppealTopic(
        code: json["code"],
        nameRu: json["nameRu"],
        nameKz: json["nameKz"],
        nameEn: json["nameEn"],
      );

  Map<String, dynamic> toMap() => {
        "code": code,
        "nameRu": nameRu,
        "nameKz": nameKz,
        "nameEn": nameEn,
      };
}
