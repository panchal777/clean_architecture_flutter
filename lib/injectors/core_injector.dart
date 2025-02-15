import 'package:clean_architecture_flutter/injectors/main_injector.dart';

import '../core/base_services/logger/loger_service.dart';

class CoreInjector {
  CoreInjector._();

  static void init() async {
    final injector = MainInjector.instance;

    injector..registerFactory<LogService>(LogServiceImpl.new);
    // ..registerSingleton<LocalStorageService>(
    //   SharedPreferencesService(
    //     logService: injector(),
    //   ),
    //   signalsReady: true,
    // )
    // ..registerSingleton<AppService>(
    //   AppServiceImpl(
    //     localStorageService: injector(),
    //   ),
    // );
  }
}
