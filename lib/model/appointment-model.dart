// https://app.quicktype.io/
import 'dart:convert';

class AppointmentModel {
  DateTime scheduledTime;

  AppointmentModel({
    this.scheduledTime,
  });

  factory AppointmentModel.fromRawJson(String str) => AppointmentModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AppointmentModel.fromJson(Map<String, dynamic> json) => new AppointmentModel(
    scheduledTime: DateTime.parse(json["scheduledTime"]),
  );

  Map<String, dynamic> toJson() => {
    "scheduledTime": scheduledTime.toIso8601String(),
  };
}