// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Defect.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DefectAdapter extends TypeAdapter<Defect> {
  @override
  final int typeId = 35;

  @override
  Defect read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Defect(
      entityName: fields[0] as String,
      id: fields[1] as String,
      defect: fields[2] as String,
      comment: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Defect obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.entityName)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.defect)
      ..writeByte(3)
      ..write(obj.comment);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DefectAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
