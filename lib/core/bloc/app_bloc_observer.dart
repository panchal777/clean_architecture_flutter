import 'package:clean_architecture_flutter/injectors/main_injector.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../base_services/logger/loger_service.dart';

class AppBlocObserver extends BlocObserver {
  AppBlocObserver() {
    _logService = MainInjector.instance<LogService>();
  }

  late final LogService _logService;

  @override
  void onCreate(BlocBase bloc) {
    _logService.i('BLoC: ${bloc.runtimeType} created');
    super.onCreate(bloc);
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    _logService.i('Event: ${event.runtimeType} added');
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
  }
}
