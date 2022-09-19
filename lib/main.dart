import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/app/app.dart';
import 'package:restaurant_app/app/bloc_observer.dart';
import 'package:restaurant_app/injection.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  configureDependencies();

  runApp(const MyApp());
}
