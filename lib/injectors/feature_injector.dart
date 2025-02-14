import 'package:clean_architecture_flutter/features/company/data/data_source/company_local_src.dart';
import 'package:clean_architecture_flutter/features/company/data/data_source/company_local_src_impl.dart';
import 'package:clean_architecture_flutter/features/company/data/repositories/company_repository_impl.dart';
import 'package:clean_architecture_flutter/features/company/domain/repositories/company_repository.dart';
import 'package:clean_architecture_flutter/features/company/presentation/bloc/company_bloc.dart';
import 'package:clean_architecture_flutter/injectors/main_injector.dart';

class FeatureInjector {
  FeatureInjector._();

  static void init() async {
    final injector = MainInjector.instance;

    // Bloc
    injector.registerFactory(() => CompanyBloc(companyRepository: injector()));

    // Repository
    injector.registerLazySingleton<CompanyRepository>(
        () => CompanyRepositoryImpl(companyLocalSrc: injector()));

    // Data sources
    injector
        .registerLazySingleton<CompanyLocalSrc>(() => CompanyLocalSrcImpl());
  }
}
