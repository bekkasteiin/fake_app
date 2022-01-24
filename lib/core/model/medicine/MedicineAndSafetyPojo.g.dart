// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MedicineAndSafetyPojo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MedicineAndSafetyPojoAdapter extends TypeAdapter<MedicineAndSafetyPojo> {
  @override
  final int typeId = 47;

  @override
  MedicineAndSafetyPojo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MedicineAndSafetyPojo(
      entityName: fields[0] as String,
      instanceName: fields[1] as String,
      id: fields[2] as String,
      code: fields[3] as String,
      safety: fields[4] as bool,
      medicine: fields[5] as bool,
      checkDate: fields[6] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, MedicineAndSafetyPojo obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.entityName)
      ..writeByte(1)
      ..write(obj.instanceName)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.code)
      ..writeByte(4)
      ..write(obj.safety)
      ..writeByte(5)
      ..write(obj.medicine)
      ..writeByte(6)
      ..write(obj.checkDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MedicineAndSafetyPojoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
