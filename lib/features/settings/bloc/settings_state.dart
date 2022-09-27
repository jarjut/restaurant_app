// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'settings_bloc.dart';

@JsonSerializable()
class SettingsState extends Equatable {
  final bool isDarkMode;
  final bool dailyReminder;

  const SettingsState({
    this.isDarkMode = false,
    this.dailyReminder = false,
  });

  @override
  List<Object> get props => [isDarkMode, dailyReminder];

  SettingsState copyWith({
    bool? isDarkMode,
    bool? dailyReminder,
  }) {
    return SettingsState(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      dailyReminder: dailyReminder ?? this.dailyReminder,
    );
  }

  factory SettingsState.fromJson(Map<String, dynamic> json) =>
      _$SettingsStateFromJson(json);

  Map<String, dynamic> toJson() => _$SettingsStateToJson(this);
}
