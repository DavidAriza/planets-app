// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'planet.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlanetAdapter extends TypeAdapter<Planet> {
  @override
  final int typeId = 0;

  @override
  Planet read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Planet(
      name: fields[0] as String?,
      mass: fields[1] as String?,
      orbitalDisctance: fields[2] as num?,
      image: fields[3] as String?,
      description: fields[4] as String?,
      isInFavorites: fields[5] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, Planet obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.mass)
      ..writeByte(2)
      ..write(obj.orbitalDisctance)
      ..writeByte(3)
      ..write(obj.image)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.isInFavorites);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlanetAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
