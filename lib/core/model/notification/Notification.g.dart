// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Notification.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NotificationsAdapter extends TypeAdapter<Notifications> {
  @override
  final int typeId = 49;

  @override
  Notifications read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Notifications(
      entityName: fields[0] as String,
      id: fields[1] as String,
      notification: fields[2] as String,
      person: fields[3] as Person,
      isCloseable: fields[4] as bool,
      status: fields[7] as String,
      title: fields[8] as String,
      notificationTypeCode: fields[5] as String,
      createTs: fields[6] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Notifications obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.entityName)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.notification)
      ..writeByte(3)
      ..write(obj.person)
      ..writeByte(4)
      ..write(obj.isCloseable)
      ..writeByte(5)
      ..write(obj.notificationTypeCode)
      ..writeByte(6)
      ..write(obj.createTs)
      ..writeByte(7)
      ..write(obj.status)
      ..writeByte(8)
      ..write(obj.title);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotificationsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
