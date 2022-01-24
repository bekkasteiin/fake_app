// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Assignment.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AssignmentAdapter extends TypeAdapter<Assignment> {
  @override
  final int typeId = 3;

  @override
  Assignment read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Assignment(
      entityName: fields[0] as String,
      id: fields[1] as String,
      orderNumber: fields[2] as String,
      address: fields[3] as String,
      person: fields[4] as Person,
      groupId: fields[5] as String,
      organization: fields[7] as Organization,
      job: fields[8] as Job,
      rating: fields[6] as Rating,
      department: fields[9] as Department,
      limits: fields[10] as FoodLimits,
      percentilePojo: fields[11] as PercentilePojo,
    );
  }

  @override
  void write(BinaryWriter writer, Assignment obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.entityName)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.orderNumber)
      ..writeByte(3)
      ..write(obj.address)
      ..writeByte(4)
      ..write(obj.person)
      ..writeByte(5)
      ..write(obj.groupId)
      ..writeByte(6)
      ..write(obj.rating)
      ..writeByte(7)
      ..write(obj.organization)
      ..writeByte(8)
      ..write(obj.job)
      ..writeByte(9)
      ..write(obj.department)
      ..writeByte(10)
      ..write(obj.limits)
      ..writeByte(11)
      ..write(obj.percentilePojo);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AssignmentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
