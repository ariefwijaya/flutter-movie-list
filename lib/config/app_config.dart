
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_movie_list/config/themes.dart';
import 'package:flutter_movie_list/core/models/language_model.dart';

/// The class where the centralized configuration is set.
/// This can be changed before built
class AppConfig {
  /// Application Name, this will be visible as an application title 
  static const String appName = "Xfers Test: Movie List";
  /// Environment file name for production.
  /// This will be loaded in main() function
  static const String envProd = ".env.prod";
  /// Environment file name for production.
  /// This will be loaded in main() function
  static const String envDev = ".env.dev";
  /// This is Base URL for RestFul API
  static String get baseUrl => dotenv.env['BASE_URL'] as String;
  /// Flag to show debug logs when its set to true
  static bool get showLog => int.tryParse(dotenv.env['SHOW_LOG']!) ==1;
  /// Maximum timeout when connect to Restful API
  static int? get apiConnectTimeout => int.tryParse(dotenv.env['API_CONNECT_TIMEOUT']!);
  /// Maximum timeout when receiving response from Restful API
  static int? get apiReceiveTimeout =>int.tryParse(dotenv.env['API_RECEIVE_TIMEOUT']!);
  /// Default Size of pagination if not set
  static int? get defaultPaginationLimit =>
      int.tryParse(dotenv.env['DEFAULT_PAGINATION_LIMIT']!);
  /// Default language for this app localizations.
  /// Default to `id => Bahasa Indonesia` 
  static final LanguageModel defaultLanguage = supportedLanguageList[0];
  /// List of available languanges in this app.
  static final List<LanguageModel> supportedLanguageList = <LanguageModel>[
    LanguageModel(languageCode: 'id', name: 'Bahasa Indonesia'),
    LanguageModel(languageCode: 'en', name: 'English')
  ];
  /// Price format to show
  static const String priceFormat = ',###.00';
  /// Default theme Style for this app [ThemeType.Light]
  static final ThemeType defaultTheme = ThemeType.Light;
  /// Date Time format to display. Eg, 2021-03-04 23:30:15
  static final DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
  /// Date format to display. Eg, 2021-03-04
  static final DateFormat dateOnlyFormat = DateFormat('yyyy-MM-dd');
  /// Time format to display. Eg, 21:12:33
  static final DateFormat timeFormat = DateFormat('HH:mm:ss');
  /// Time format to display. Eg, 21:12
  static final DateFormat timeMinutesFormat = DateFormat('HH:mm');
}
