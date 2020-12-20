// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spor.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SporBilgileriAdapter extends TypeAdapter<SporBilgileri> {
  @override
  final int typeId = 0;

  @override
  SporBilgileri read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SporBilgileri(
      baslangiczamani: fields[0] as String,
      bitiszamani: fields[1] as String,
      kalori: fields[4] as int,
      sportipi: fields[2] as String,
      l: (fields[3] as List)?.cast<Location>(),
    );
  }

  @override
  void write(BinaryWriter writer, SporBilgileri obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.baslangiczamani)
      ..writeByte(1)
      ..write(obj.bitiszamani)
      ..writeByte(2)
      ..write(obj.sportipi)
      ..writeByte(3)
      ..write(obj.l)
      ..writeByte(4)
      ..write(obj.kalori);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SporBilgileriAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
