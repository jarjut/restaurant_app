import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:restaurant_app/utils/background_service.dart';
import 'package:restaurant_app/utils/date_helper.dart';

part 'settings_event.dart';
part 'settings_state.dart';
part 'settings_bloc.g.dart';

class SettingsBloc extends HydratedBloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(const SettingsState()) {
    on<SettingsChangeDailyReminder>(
      (event, emit) async {
        final isScheduled = event.value;
        if (isScheduled) {
          debugPrint(
              'Scheduling Activated Start at ${DateTimeHelper.format()}');
          await AndroidAlarmManager.periodic(
            const Duration(hours: 24),
            1,
            BackgroundService.callback,
            startAt: DateTimeHelper.format(),
            exact: true,
            wakeup: true,
          );
        } else {
          debugPrint('Scheduling Canceled');
          await AndroidAlarmManager.cancel(1);
        }
        emit(state.copyWith(dailyReminder: isScheduled));
      },
      transformer: droppable(),
    );
  }

  @override
  SettingsState? fromJson(Map<String, dynamic> json) {
    return SettingsState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(SettingsState state) {
    return state.toJson();
  }
}
