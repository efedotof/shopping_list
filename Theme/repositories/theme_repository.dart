

import 'package:shared_preferences/shared_preferences.dart';

import 'theme_interf.dart';

class  ThemeRepository implements ThemeInterf {
  ThemeRepository({required this.preferences});
  
  
  final SharedPreferences preferences;

  static const _isDarkThemeSelectedKey = 'dark_theme_selected_key';

  @override
  bool isDarkTheme() {
    final selected = preferences.getBool(_isDarkThemeSelectedKey);
    return selected ?? false;
  }

  @override
  Future<void> setDarkThemeSelected(bool selected) async {
    await preferences.setBool(_isDarkThemeSelectedKey, selected);
  }
  


}