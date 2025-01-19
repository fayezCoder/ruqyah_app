import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static const String _favoritesKey = 'favorites_dhikr';
  static const String _countersKey = 'dhikr_counters';
  static const String _darkModeKey = 'dark_mode';
  static const String _arabicFontSizeKey = 'arabic_font_size';
  static const String _translationFontSizeKey = 'translation_font_size';
  static const String _notificationsEnabledKey = 'notifications_enabled';
  static const String _languageCodeKey = 'language_code';
  static const String _fontSizeKey = 'fontSize';
  static const String _showTranslationKey = 'showTranslation';

  // Save favorite status
  static Future<void> toggleFavorite(String dhikrText) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = await getFavorites();

    if (favorites.contains(dhikrText)) {
      favorites.remove(dhikrText);
    } else {
      favorites.add(dhikrText);
    }

    await prefs.setStringList(_favoritesKey, favorites);
  }

  // Get all favorites
  static Future<List<String>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_favoritesKey) ?? [];
  }

  // Save counter for a specific dhikr
  static Future<void> incrementCounter(String dhikrText) async {
    final prefs = await SharedPreferences.getInstance();
    final counters = await getCounters();

    counters[dhikrText] = (counters[dhikrText] ?? 0) + 1;
    await prefs.setString(_countersKey, json.encode(counters));
  }

  // Reset counter for a specific dhikr
  static Future<void> resetCounter(String dhikrText) async {
    final prefs = await SharedPreferences.getInstance();
    final counters = await getCounters();

    counters[dhikrText] = 0;
    await prefs.setString(_countersKey, json.encode(counters));
  }

  // Get all counters
  static Future<Map<String, int>> getCounters() async {
    final prefs = await SharedPreferences.getInstance();
    final String? countersJson = prefs.getString(_countersKey);
    if (countersJson == null) return {};

    Map<String, dynamic> decoded = json.decode(countersJson);
    return decoded.map((key, value) => MapEntry(key, value as int));
  }

  // Theme preferences
  static Future<bool> isDarkMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_darkModeKey) ?? false;
  }

  static Future<void> setDarkMode(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_darkModeKey, value);
  }

  // Font size preferences
  static Future<double> getArabicFontSize() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(_arabicFontSizeKey) ?? 20.0;
  }

  static Future<void> setArabicFontSize(double size) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_arabicFontSizeKey, size);
  }

  static Future<double> getTranslationFontSize() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(_translationFontSizeKey) ?? 16.0;
  }

  static Future<void> setTranslationFontSize(double size) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_translationFontSizeKey, size);
  }

  // Notifications preferences
  static Future<bool> areNotificationsEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_notificationsEnabledKey) ?? true;
  }

  static Future<void> setNotificationsEnabled(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_notificationsEnabledKey, value);
  }

  // Language preferences
  static Future<String> getLanguageCode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_languageCodeKey) ?? 'ar';
  }

  static Future<void> setLanguageCode(String code) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageCodeKey, code);
  }

  static Future<double> getFontSize() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(_fontSizeKey) ?? 18.0;
  }

  static Future<void> setFontSize(double size) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_fontSizeKey, size);
  }

  static Future<bool> getShowTranslation() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_showTranslationKey) ?? true;
  }

  static Future<void> setShowTranslation(bool show) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_showTranslationKey, show);
  }
}
