import 'package:clean_architecture_flutter/core/router/app_router.dart';
import 'package:clean_architecture_flutter/features/company/presentation/bloc/company_bloc.dart';
import 'package:clean_architecture_flutter/injectors/main_injector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MainInjector.init();
  await MainInjector.instance.allReady();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CompanyBloc>(
            create: (context) => MainInjector.instance<CompanyBloc>())
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Assessment',
        //Adding go router
        routerConfig: AppRouter.baseRouters,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          appBarTheme: AppBarTheme(color: Colors.deepPurple),
          useMaterial3: true,
        ),
      ),
    );
  }
}
