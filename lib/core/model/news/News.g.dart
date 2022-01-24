// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'News.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NewsAdapter extends TypeAdapter<News> {
  @override
  final int typeId = 48;

  @override
  News read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return News(
      entityName: fields[0] as String,
      instanceName: fields[1] as String,
      id: fields[2] as String,
      image: fields[3] as String,
      text: fields[5] as String,
      isCloseable: fields[4] as bool,
      title: fields[6] as String,
      type: fields[7] as String,
      newsDate: fields[8] as DateTime,
      newsType: fields[9] as String,
    );
  }

  @override
  void write(BinaryWriter writer, News obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.entityName)
      ..writeByte(1)
      ..write(obj.instanceName)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.image)
      ..writeByte(4)
      ..write(obj.isCloseable)
      ..writeByte(5)
      ..write(obj.text)
      ..writeByte(6)
      ..write(obj.title)
      ..writeByte(7)
      ..write(obj.type)
      ..writeByte(8)
      ..write(obj.newsDate)
      ..writeByte(9)
      ..write(obj.newsType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NewsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
