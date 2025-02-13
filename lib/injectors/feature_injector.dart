import 'package:clean_architecture_flutter/injectors/main_injector.dart';

class FeatureInjector {
  FeatureInjector._();

  static void init() async {
    final injector = MainInjector.instance;
    //
    // injector
    //   ..registerFactory<LogService>(DebugLogService.new)
    //   ..registerSingleton<LocalStorageService>(
    //     SharedPreferencesService(
    //       logService: injector(),
    //     ),
    //     signalsReady: true,
    //   )
    //   ..registerSingleton<AppService>(
    //     AppServiceImpl(
    //       localStorageService: injector(),
    //     ),
    //   );
  }
}
