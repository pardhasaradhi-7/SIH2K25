// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'AgriAssist';

  @override
  String get welcomeMessage => 'Welcome to AgriAssist';

  @override
  String get weatherForecast => 'Weather Forecast';

  @override
  String get cropGuide => 'Crop Guide';

  @override
  String get diseaseDetector => 'Disease Detector';

  @override
  String get marketPrices => 'Market Prices';

  @override
  String get login => 'Login';

  @override
  String get register => 'Register';
}
