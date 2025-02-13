import 'package:clean_architecture_flutter/injectors/core_injector.dart';
import 'package:clean_architecture_flutter/core/router/app_router.dart';
import 'package:clean_architecture_flutter/injectors/feature_injector.dart';
import 'package:get_it/get_it.dart';

class MainInjector {
  MainInjector._();

  static GetIt instance = GetIt.instance;

  static void init() {
    CoreInjector.init();
    FeatureInjector.init();
    AppRouter.init();
  }

  static void reset() {
    instance.reset();
  }

  static void resetLazySingleton() {
    instance.resetLazySingleton();
  }
}
