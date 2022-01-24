// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_descriptor.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FileDescriptorAdapter extends TypeAdapter<FileDescriptor> {
  @override
  final int typeId = 124;

  @override
  FileDescriptor read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FileDescriptor(
      entityName: fields[0] as String,
      instanceName: fields[1] as String,
      id: fields[2] as String,
      extension: fields[3] as String,
      name: fields[4] as String,
      version: fields[5] as int,
      createDate: fields[6] as DateTime,
      byte: fields[9] as Uint8List,
      localPath: fields[7] as String,
      fileName: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, FileDescriptor obj) {
    writer
      ..writeByte(10)
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
      ..write(obj.version)
      ..writeByte(6)
      ..write(obj.createDate)
      ..writeByte(7)
      ..write(obj.localPath)
      ..writeByte(8)
      ..write(obj.fileName)
      ..writeByte(9)
      ..write(obj.byte);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FileDescriptorAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
