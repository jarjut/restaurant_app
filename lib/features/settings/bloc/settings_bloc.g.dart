// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_bloc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SettingsState _$SettingsStateFromJson(Map<String, dynamic> json) =>
    SettingsState(
      isDarkMode: json['isDarkMode'] as bool? ?? false,
      dailyReminder: json['dailyReminder'] as bool? ?? false,
    );

Map<String, dynamic> _$SettingsStateToJson(SettingsState instance) =>
    <String, dynamic>{
      'isDarkMode': instance.isDarkMode,
      'dailyReminder': instance.dailyReminder,
    };
