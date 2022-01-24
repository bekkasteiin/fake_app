import 'package:hive/hive.dart';

part 'CarAddress.g.dart';

@HiveType(typeId: 120)
class CarAddress {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final int age;

  CarAddress(this.name, this.age);
}
