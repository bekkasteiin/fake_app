// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_dictionary.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AbstractDictionaryAdapter extends TypeAdapter<AbstractDictionary> {
  @override
  final int typeId = 123;

  @override
  AbstractDictionary read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AbstractDictionary(
      entityName: fields[0] as String,
      instanceName: fields[1] as String,
      id: fields[2] as String,
      code: fields[3] as String,
      langValue: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AbstractDictionary obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.entityName)
      ..writeByte(1)
      ..write(obj.instanceName)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.code)
      ..writeByte(4)
      ..write(obj.langValue);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AbstractDictionaryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
