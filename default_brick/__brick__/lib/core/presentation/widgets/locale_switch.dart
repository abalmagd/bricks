import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:{{name.snakeCase()}}/core/app/localization/localization.dart';

class LocaleSwitch extends StatelessWidget {
  const LocaleSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    final currentLocale = context.locale;
    return DropdownButton<Locale>(
      value: currentLocale,
      underline: const SizedBox.shrink(),
      isDense: true,
      items: Localization.supportedLocales
          .map(
            (l) => DropdownMenuItem(
              value: l.locale,
              child: Text(l.locale.languageCode.tr()),
            ),
          )
          .toList(),
      onChanged: (locale) {
        if (locale == null || locale == currentLocale) return;
        context.setLocale(locale);
      },
    );
  }
}
