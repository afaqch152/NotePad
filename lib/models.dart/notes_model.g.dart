// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notes_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NotesModlesAdapter extends TypeAdapter<NotesModles> {
  @override
  final int typeId = 0;

  @override
  NotesModles read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NotesModles(
      title: fields[0] as String,
      desription: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, NotesModles obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.desription);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotesModlesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
