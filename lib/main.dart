import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:restaurant_app/app/app.dart';
import 'package:restaurant_app/app/bloc_observer.dart';
import 'package:restaurant_app/database/isar.dart';
import 'package:restaurant_app/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final hydratedStorage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
  HydratedBloc.storage = hydratedStorage;
  Bloc.observer = SimpleBlocObserver();

  await IsarDatabase().init();
  configureDependencies();

  runApp(const MyApp());
}
