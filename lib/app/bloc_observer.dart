import 'dart:developer';

import 'package:bloc/bloc.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    log('[${bloc.runtimeType}] $change', name: 'BloC');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    log('[${bloc.runtimeType}] $transition', name: 'BloC');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    log(
      '[${bloc.runtimeType}] $error',
      name: 'BloC',
      stackTrace: stackTrace,
    );
    super.onError(bloc, error, stackTrace);
  }
}
