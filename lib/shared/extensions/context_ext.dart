import 'package:base/presentation/resources/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

extension BuildContextExt on BuildContext {
  AppLocalizations? get l10n => AppLocalizations.of(this);
}
