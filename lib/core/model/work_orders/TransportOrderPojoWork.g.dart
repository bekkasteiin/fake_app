// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TransportOrderPojoWork.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TransportOrderPojoWorkAdapter
    extends TypeAdapter<TransportOrderPojoWork> {
  @override
  final int typeId = 39;

  @override
  TransportOrderPojoWork read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TransportOrderPojoWork(
      entityName: fields[0] as String,
      id: fields[1] as String,
      uom: fields[2] as String,
      laborSpending: (fields[3] as List)?.cast<WorkLaborSpending>(),
      route: fields[4] as String,
      trip: fields[5] as double,
      hazard: fields[6] as bool,
      person: fields[7] as Person,
      workType: fields[8] as String,
      equipment: fields[9] as String,
      weight: fields[10] as double,
      operationType: fields[11] as String,
      workPlace: fields[12] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TransportOrderPojoWork obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.entityName)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.uom)
      ..writeByte(3)
      ..write(obj.laborSpending)
      ..writeByte(4)
      ..write(obj.route)
      ..writeByte(5)
      ..write(obj.trip)
      ..writeByte(6)
      ..write(obj.hazard)
      ..writeByte(7)
      ..write(obj.person)
      ..writeByte(8)
      ..write(obj.workType)
      ..writeByte(9)
      ..write(obj.equipment)
      ..writeByte(10)
      ..write(obj.weight)
      ..writeByte(11)
      ..write(obj.operationType)
      ..writeByte(12)
      ..write(obj.workPlace);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransportOrderPojoWorkAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
