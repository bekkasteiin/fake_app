// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Rating.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RatingAdapter extends TypeAdapter<Rating> {
  @override
  final int typeId = 69;

  @override
  Rating read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Rating(
      entityName: fields[0] as String,
      id: fields[1] as String,
      disciplineRating: fields[2] as double,
      safetyRating: fields[3] as double,
      testRating: fields[4] as double,
      rating: fields[5] as double,
      productivityRating: fields[6] as double,
      wasteRating: fields[7] as double,
    );
  }

  @override
  void write(BinaryWriter writer, Rating obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.entityName)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.disciplineRating)
      ..writeByte(3)
      ..write(obj.safetyRating)
      ..writeByte(4)
      ..write(obj.testRating)
      ..writeByte(5)
      ..write(obj.rating)
      ..writeByte(6)
      ..write(obj.productivityRating)
      ..writeByte(7)
      ..write(obj.wasteRating);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RatingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
