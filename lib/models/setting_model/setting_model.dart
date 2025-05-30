import 'package:hive_flutter/hive_flutter.dart';
part 'setting_model.g.dart';


@HiveType(typeId: 0)
class SettingModel {
  @HiveField(0)
  bool? isReceiveNotifWhenAccepted;

  @HiveField(1)
  bool? isReceiveNotifWhenClose;

  @HiveField(2)
  bool? isSendNotification;

  @HiveField(3)
  bool? isOnDuty;

  SettingModel(
      {this.isOnDuty,
      this.isReceiveNotifWhenAccepted,
      this.isReceiveNotifWhenClose,
      this.isSendNotification});
}
