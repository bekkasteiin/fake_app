// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class KrjConfigAdapter extends TypeAdapter<KrjConfig> {
  @override
  final int typeId = 79;

  @override
  KrjConfig read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return KrjConfig(
      entityName: fields[0] as String,
      instanceName: fields[1] as String,
      id: fields[2] as String,
      code: fields[3] as String,
      description1: fields[4] as String,
      configFile: fields[5] as ConfigFile,
      isSystemRecord: fields[6] as bool,
      active: fields[7] as bool,
      isDefault: fields[8] as bool,
      langValue1: fields[9] as String,
      order: fields[10] as int,
    );
  }

  @override
  void write(BinaryWriter writer, KrjConfig obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.entityName)
      ..writeByte(1)
      ..write(obj.instanceName)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.code)
      ..writeByte(4)
      ..write(obj.description1)
      ..writeByte(5)
      ..write(obj.configFile)
      ..writeByte(6)
      ..write(obj.isSystemRecord)
      ..writeByte(7)
      ..write(obj.active)
      ..writeByte(8)
      ..write(obj.isDefault)
      ..writeByte(9)
      ..write(obj.langValue1)
      ..writeByte(10)
      ..write(obj.order);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is KrjConfigAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
