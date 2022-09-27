part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => [];
}

class SettingsChangeDailyReminder extends SettingsEvent {
  final bool value;

  const SettingsChangeDailyReminder(this.value);

  @override
  List<Object> get props => [value];
}
