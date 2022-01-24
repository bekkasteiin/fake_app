// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ConfigFileAdapter extends TypeAdapter<ConfigFile> {
  @override
  final int typeId = 80;

  @override
  ConfigFile read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ConfigFile(
      entityName: fields[0] as String,
      instanceName: fields[1] as String,
      id: fields[2] as String,
      extension: fields[3] as String,
      name: fields[4] as String,
      createDate: fields[5] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, ConfigFile obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.entityName)
      ..writeByte(1)
      ..write(obj.instanceName)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.extension)
      ..writeByte(4)
      ..write(obj.name)
      ..writeByte(5)
      ..write(obj.createDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConfigFileAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
