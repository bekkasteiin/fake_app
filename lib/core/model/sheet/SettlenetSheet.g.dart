// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SettlenetSheet.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SettlenetSheetAdapter extends TypeAdapter<SettlenetSheet> {
  @override
  final int typeId = 58;

  @override
  SettlenetSheet read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SettlenetSheet(
      entityName: fields[0] as String,
      instanceName: fields[1] as String,
      id: fields[2] as String,
      date: fields[3] as DateTime,
      period: fields[4] as String,
      fileId: fields[5] as String,
      seen: fields[6] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, SettlenetSheet obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.entityName)
      ..writeByte(1)
      ..write(obj.instanceName)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.date)
      ..writeByte(4)
      ..write(obj.period)
      ..writeByte(5)
      ..write(obj.fileId)
      ..writeByte(6)
      ..write(obj.seen);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SettlenetSheetAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
