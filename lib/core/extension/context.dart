import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension AppContext on BuildContext {
  ThemeData get them => Theme.of(this);
  AppLocalizations get lang => AppLocalizations.of(this)!;
}
