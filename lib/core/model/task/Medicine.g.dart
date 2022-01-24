// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Medicine.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MedicineAdapter extends TypeAdapter<Medicine> {
  @override
  final int typeId = 27;

  @override
  Medicine read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Medicine(
      entityName: fields[0] as String,
      id: fields[1] as String,
      check: fields[2] as bool,
      checkDate: fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Medicine obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.entityName)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.check)
      ..writeByte(3)
      ..write(obj.checkDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MedicineAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
