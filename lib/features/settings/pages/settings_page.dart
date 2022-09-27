import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/features/settings/bloc/settings_bloc.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  static const routeName = '/settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        foregroundColor: Colors.black,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
      ),
      body: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          return ListView(
            children: [
              ListTile(
                title: const Text('Daily Reminder'),
                trailing: Switch(
                  value: state.dailyReminder,
                  onChanged: (value) => context
                      .read<SettingsBloc>()
                      .add(SettingsChangeDailyReminder(value)),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
