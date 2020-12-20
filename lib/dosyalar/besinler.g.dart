// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'besinler.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BesinlerAdapter extends TypeAdapter<Besinler> {
  @override
  final int typeId = 2;

  @override
  Besinler read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Besinler(
      id: fields[0] as int,
      isim: fields[2] as String,
      kalori: fields[3] as int,
      value: fields[1] as bool,
      miktar: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Besinler obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.value)
      ..writeByte(2)
      ..write(obj.isim)
      ..writeByte(3)
      ..write(obj.kalori)
      ..writeByte(4)
      ..write(obj.miktar);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BesinlerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
