// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'HistoryEatingOrder.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HistoryEatingOrderAdapter extends TypeAdapter<HistoryEatingOrder> {
  @override
  final int typeId = 23;

  @override
  HistoryEatingOrder read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HistoryEatingOrder(
      entityName: fields[0] as String,
      instanceName: fields[1] as String,
      id: fields[2] as String,
      orderDateTime: fields[3] as DateTime,
      locationName: fields[4] as String,
      eatingMenus: (fields[5] as List)?.cast<EatingMenus>(),
      location: fields[6] as String,
      docDate: fields[7] as DateTime,
      comment: fields[8] as String,
      locationGroupName: fields[9] as String,
      status: fields[10] as String,
      mealtimeId: fields[11] as String,
      forceAccept: fields[12] as bool,
      code: fields[13] as String,
    );
  }

  @override
  void write(BinaryWriter writer, HistoryEatingOrder obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.entityName)
      ..writeByte(1)
      ..write(obj.instanceName)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.orderDateTime)
      ..writeByte(4)
      ..write(obj.locationName)
      ..writeByte(5)
      ..write(obj.eatingMenus)
      ..writeByte(6)
      ..write(obj.location)
      ..writeByte(7)
      ..write(obj.docDate)
      ..writeByte(8)
      ..write(obj.comment)
      ..writeByte(9)
      ..write(obj.locationGroupName)
      ..writeByte(10)
      ..write(obj.status)
      ..writeByte(11)
      ..write(obj.mealtimeId)
      ..writeByte(12)
      ..write(obj.forceAccept)
      ..writeByte(13)
      ..write(obj.code);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HistoryEatingOrderAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
