// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'observation.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ObservationAdapter extends TypeAdapter<Observation> {
  @override
  final int typeId = 127;

  @override
  Observation read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Observation(
      entityName: fields[0] as String,
      instanceName: fields[1] as String,
      id: fields[2] as String,
      observationKindSitutation: fields[3] as AbstractDictionary,
      observationKindDanger: fields[4] as AbstractDictionary,
      observationSevirityConsequences: fields[5] as AbstractDictionary,
      observationCategory: fields[6] as AbstractDictionary,
      comment: fields[7] as String,
      isChecked: fields[8] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Observation obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.entityName)
      ..writeByte(1)
      ..write(obj.instanceName)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.observationKindSitutation)
      ..writeByte(4)
      ..write(obj.observationKindDanger)
      ..writeByte(5)
      ..write(obj.observationSevirityConsequences)
      ..writeByte(6)
      ..write(obj.observationCategory)
      ..writeByte(7)
      ..write(obj.comment)
      ..writeByte(8)
      ..write(obj.isChecked);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ObservationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
