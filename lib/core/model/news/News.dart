import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:intl/intl.dart' show DateFormat;

part 'News.g.dart';

@HiveType(typeId: 48)
class News {
  @HiveField(0)
  String entityName;
  @HiveField(1)
  String instanceName;
  @HiveField(2)
  String id;
  @HiveField(3)
  String image;
  @HiveField(4)
  bool isCloseable;
  @HiveField(5)
  String text;
  @HiveField(6)
  String title;
  @HiveField(7)
  String type;
  @HiveField(8)
  DateTime newsDate;
  @HiveField(9)
  String newsType;

  News(
      {this.entityName,
      this.instanceName,
      this.id,
      this.image,
      this.text,
      this.isCloseable,
      this.title,
      this.type,
      this.newsDate,
      this.newsType});

  fromJson(String str) => News.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory News.fromMap(Map<String, dynamic> json) => News(
        entityName: json["_entityName"] == null ? null : json["_entityName"],
        instanceName:
            json["_instanceName"] == null ? null : json["_instanceName"],
        id: json["id"] == null ? null : json["id"],
        isCloseable: json["isCloseable"] == null ? true : json["isCloseable"],
        image: json["image"] == null ? null : json["image"],
        text: json["text"] == null ? null : json["text"],
        title: json["title"] == null ? null : json["title"],
        type: json["type"] == null ? null : json["type"],
        newsType: json["newsType"] == null ? null : json["newsType"],
        newsDate:
            json["newsDate"] == null ? null : DateTime.parse(json["newsDate"]),
      );

  Map<String, dynamic> toMap() => {
        "_entityName": entityName == null ? null : entityName,
        "_instanceName": instanceName == null ? null : instanceName,
        "id": id == null ? null : id,
        "image": image == null ? null : image,
        "isCloseable": isCloseable == null ? null : isCloseable,
        "text": text == null ? null : text,
        "title": title == null ? null : title,
        "type": type == null ? null : type,
        "newsType": newsType == null ? null : newsType,
        "newsDate": DateFormat("yyyy-MM-dd HH:mm:ss.SSS").format(newsDate),
      };
}
