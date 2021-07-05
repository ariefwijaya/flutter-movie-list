import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_movie_list/config/themes.dart';

import 'config/app_config.dart';
import 'config/router.dart';
import 'core/blocs/app/app_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env.dev");

  if (AppConfig.showLog) {
    Bloc.observer = MyBlocObserver();
  }

  runApp(EasyLocalization(
        supportedLocales:
            AppConfig.supportedLanguageList.map((e) => e.toLocale()).toList(),
        path: "assets/langs",
        startLocale: AppConfig.defaultLanguage.toLocale(),
        fallbackLocale: AppConfig.defaultLanguage.toLocale(),
        useOnlyLangCode: true,
        child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppCubit>(
          create: (BuildContext context) => AppCubit(),
        ),
      ],
      child: BlocBuilder<AppCubit, AppState>(
        builder: _buildWithTheme,
      ),
    );
  }

  Widget _buildWithTheme(BuildContext context, AppState appState) {
    return MaterialApp(
        navigatorKey: GlobalKey<NavigatorState>(),
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: appState.language.toLocale(), 
        title: AppConfig.appName,
        theme: ThemeStyle.getAppThemeData(context, appState.themeType),
        onGenerateRoute: Routes.generateRoute,
        debugShowCheckedModeBanner: false);
  }
}

class MyBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc? bloc, Object? event) {
    super.onEvent(bloc!, event);
    print('onEvent -- bloc: ${bloc.runtimeType}, event: $event');
  }

  @override
  void onTransition(Bloc? bloc, Transition? transition) {
    super.onTransition(bloc!, transition!);
    print('onTransition -- bloc: ${bloc.runtimeType}, transition: $transition');
  }

  @override
  void onError(BlocBase cubit, Object error, StackTrace stackTrace) {
    print('onError -- cubit: ${cubit.runtimeType}, error: $error');
    super.onError(cubit, error, stackTrace);
  }
}