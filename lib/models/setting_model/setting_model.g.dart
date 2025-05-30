// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'setting_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SettingModelAdapter extends TypeAdapter<SettingModel> {
  @override
  final int typeId = 0;

  @override
  SettingModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SettingModel(
      isOnDuty: fields[3] as bool?,
      isReceiveNotifWhenAccepted: fields[0] as bool?,
      isReceiveNotifWhenClose: fields[1] as bool?,
      isSendNotification: fields[2] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, SettingModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.isReceiveNotifWhenAccepted)
      ..writeByte(1)
      ..write(obj.isReceiveNotifWhenClose)
      ..writeByte(2)
      ..write(obj.isSendNotification)
      ..writeByte(3)
      ..write(obj.isOnDuty);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SettingModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
