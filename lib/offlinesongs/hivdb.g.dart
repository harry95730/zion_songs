// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hivdb.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SongDataAdapter extends TypeAdapter<SongData> {
  @override
  final int typeId = 0;

  @override
  SongData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SongData(
      link: fields[0] as String,
      start: fields[1] as int,
      like: fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, SongData obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.link)
      ..writeByte(1)
      ..write(obj.start)
      ..writeByte(2)
      ..write(obj.like);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SongDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
