import 'dart:convert';

import 'package:hive/hive.dart';

part 'Rating.g.dart';

@HiveType(typeId: 69)
class Rating {
  Rating({
    this.entityName,
    this.id,
    this.disciplineRating,
    this.safetyRating,
    this.testRating,
    this.rating,
    this.productivityRating,
    this.wasteRating,
  });

  @HiveField(0)
  String entityName;
  @HiveField(1)
  String id;
  @HiveField(2)
  double disciplineRating;
  @HiveField(3)
  double safetyRating;
  @HiveField(4)
  double testRating;
  @HiveField(5)
  double rating;
  @HiveField(6)
  double productivityRating;
  @HiveField(7)
  double wasteRating;

  factory Rating.fromJson(String str) => Rating.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Rating.fromMap(Map<String, dynamic> json) => Rating(
        entityName: json["_entityName"],
        id: json["id"],
        disciplineRating: json["disciplineRating"],
        safetyRating: json["safetyRating"],
        testRating: json["testRating"],
        rating: json["rating"],
        productivityRating: json["productivityRating"],
        wasteRating: json["wasteRating"],
      );

  Map<String, dynamic> toMap() => {
        "_entityName": entityName,
        "id": id,
        "disciplineRating": disciplineRating,
        "safetyRating": safetyRating,
        "testRating": testRating,
        "rating": rating,
        "productivityRating": productivityRating,
        "wasteRating": wasteRating,
      };
}
