import 'package:flutter/material.dart';
import '../services/preferences_service.dart';

class TextSettingsProvider with ChangeNotifier {
  double _fontSize = 18.0;

  double get fontSize => _fontSize;

  TextSettingsProvider() {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    _fontSize = await PreferencesService.getFontSize();
    notifyListeners();
  }

  Future<void> setFontSize(double size) async {
    _fontSize = size;
    await PreferencesService.setFontSize(size);
    notifyListeners();
  }
}
