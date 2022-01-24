// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SavedAddresses.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SavedAddressesAdapter extends TypeAdapter<SavedAddresses> {
  @override
  final int typeId = 56;

  @override
  SavedAddresses read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SavedAddresses(
      id: fields[0] as int,
      address: fields[1] as String,
      type: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SavedAddresses obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.address)
      ..writeByte(2)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SavedAddressesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
