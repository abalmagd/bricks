import 'dart:ui';

/// Generate LocaleKeys using this command:
/// ```flutter pub run easy_localization:generate -f keys -o locale_keys.dart -S assets/translations/ -O lib/core/app/localization```

enum AppLocale {
  en(Locale('en'))
  
  // Don't move the ;
  ;

  final Locale locale;

  const AppLocale(this.locale);
}

class Localization {
  static const supportedLocales = AppLocale.values;
}
