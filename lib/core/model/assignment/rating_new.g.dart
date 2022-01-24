// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rating_new.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PercentilePojoAdapter extends TypeAdapter<PercentilePojo> {
  @override
  final int typeId = 81;

  @override
  PercentilePojo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PercentilePojo(
      lowLimit: fields[0] as num,
      highLimit: fields[1] as num,
      lowestScore: fields[2] as num,
      highestScore: fields[3] as num,
      totalNumberOfScores: fields[4] as num,
      currentEmpRank: fields[5] as num,
      currentEmpRating: fields[6] as num,
    );
  }

  @override
  void write(BinaryWriter writer, PercentilePojo obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.lowLimit)
      ..writeByte(1)
      ..write(obj.highLimit)
      ..writeByte(2)
      ..write(obj.lowestScore)
      ..writeByte(3)
      ..write(obj.highestScore)
      ..writeByte(4)
      ..write(obj.totalNumberOfScores)
      ..writeByte(5)
      ..write(obj.currentEmpRank)
      ..writeByte(6)
      ..write(obj.currentEmpRating);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PercentilePojoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
