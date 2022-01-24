import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:hse/core/model/util_models.dart';

import 'Order.dart';

part 'CarOrder.g.dart';

@HiveType(typeId: 66)
class CarOrder {
  @HiveField(0)
  String entityName;
  @HiveField(1)
  String id;
  @HiveField(2)
  String status;
  @HiveField(3)
  DateTime requestedDate;
  @HiveField(4)
  String toAddress;
  @HiveField(5)
  String fromAddress;
  @HiveField(6)
  String count;
  @HiveField(7)
  String comment;
  @HiveField(8)
  DateTime createDate;
  @HiveField(9)
  DateTime requestedTime;
  @HiveField(10)
  Order order;
  @HiveField(11)
  bool isEmergency;
  @HiveField(12)
  String typeOfCar;
  @HiveField(13)
  int rating;
  @HiveField(14)
  num cost;

  CarOrder(
      {this.entityName,
      this.id,
      this.status,
      this.requestedDate,
      this.toAddress,
      this.fromAddress,
      this.count,
      this.comment,
      this.createDate,
      this.order,
      this.isEmergency,
      this.typeOfCar,
      this.rating,
      this.cost});

  factory CarOrder.fromJson(String str) => CarOrder.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CarOrder.fromMap(Map<String, dynamic> json) => CarOrder(
        entityName: json['_entityName'],
        id: json['requestId'],
        status: json['status'],
        requestedDate:
            json['date'] == null ? null : DateTime.parse(json['date']),
        toAddress: json['to'],
        fromAddress: json['from'],
        count: json['count'],
        cost: json['cost'],
        rating: json['rating'],
        comment: json['comment'],
        createDate: json['createDate'] == null
            ? null
            : DateTime.parse(json['createDate']),
        order: json['order'] == null || json['order'] == 'null'
            ? null
            : (json['order'] is String
                ? Order.fromMap(jsonDecode(json['order']))
                : Order.fromMap(json['order'])),
        typeOfCar: json['typeOfCar'],
        isEmergency: json['isEmergency'],
      );

  Map<String, dynamic> toMap() => {
        '_entityName': entityName,
        'id': id,
        'status': status,
        'REQUESTED_DATE':
            requestedDate == null ? null : dateTimeToString(requestedDate),
        'TO_ADDRESS': toAddress,
        'FROM_ADDRESS': fromAddress,
        'cost': cost,
        'COUNT': count,
        'COMMENT': comment,
        'rating': rating,
        'CREATE_DATE': createDate == null ? null : dateTimeToString(createDate),
        'order': order == null ? null : order.toJson(),
        'typeOfCar': typeOfCar,
        'isEmergency': isEmergency,
      };
}
