// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'configuracao_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SettingsAdapter extends TypeAdapter<Settings> {
  @override
  final int typeId = 0;

  @override
  Settings read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Settings()
      ..urlacionamento = fields[0] as String
      ..delayrele = fields[1] as int
      ..keyacionamento = fields[2] as String
      ..lat = fields[3] as double?
      ..lon = fields[4] as double?
      ..urlacionamentointernet = fields[5] as String;
  }

  @override
  void write(BinaryWriter writer, Settings obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.urlacionamento)
      ..writeByte(1)
      ..write(obj.delayrele)
      ..writeByte(2)
      ..write(obj.keyacionamento)
      ..writeByte(3)
      ..write(obj.lat)
      ..writeByte(4)
      ..write(obj.lon)
      ..writeByte(5)
      ..write(obj.urlacionamentointernet);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SettingsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
