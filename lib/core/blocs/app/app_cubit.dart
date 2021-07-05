import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter_movie_list/config/app_config.dart';
import 'package:flutter_movie_list/config/themes.dart';
import 'package:flutter_movie_list/core/models/language_model.dart';
part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit()
      : super(AppState(
            language: AppConfig.defaultLanguage,
            themeType: AppConfig.defaultTheme)) {
    getConfig();
  }

  LanguageModel _language = AppConfig.defaultLanguage;
  ThemeType _themeType = AppConfig.defaultTheme;

  void getConfig() async {
    try {
      final language = _language;
      final themeType = _themeType;
      emit(AppState(language: language, themeType: themeType));
    } catch (e) {
      print(e);
    }
  }

  void setConfig({LanguageModel? language, ThemeType? themeType}) async {
    if (language != null) {
      _language = language;
    }

    if (themeType != null) {
      _themeType = themeType;
    }

    emit(AppState(language: _language, themeType: _themeType));
  }
}
