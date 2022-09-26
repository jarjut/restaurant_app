import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/app/app.dart';
import 'package:restaurant_app/app/bloc_observer.dart';
import 'package:restaurant_app/database/isar.dart';
import 'package:restaurant_app/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  await IsarDatabase().init();
  configureDependencies();

  runApp(const MyApp());
}
