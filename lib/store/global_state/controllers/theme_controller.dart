import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {
  final _storage = GetStorage();
  final _key = 'themeMode';

  // 当前主题模式
  var themeMode = ThemeMode.system.obs;

  @override
  void onInit() {
    super.onInit();
    // 从存储中加载主题
    themeMode.value = _loadThemeMode();
  }

  void _saveThemeMode(ThemeMode mode) {
    _storage.write(_key, mode.toString());
  }

  ThemeMode _loadThemeMode() {
    final mode = _storage.read<String>(_key);
    if (mode == ThemeMode.light.toString()) return ThemeMode.light;
    if (mode == ThemeMode.dark.toString()) return ThemeMode.dark;
    return ThemeMode.system;
  }

  void setDarkMode() {
    themeMode.value = ThemeMode.dark;
    _saveThemeMode(ThemeMode.dark);
  }

  void setLightMode() {
    themeMode.value = ThemeMode.light;
    _saveThemeMode(ThemeMode.light);
  }

  void toggleTheme() {
    themeMode.value =
        (themeMode.value == ThemeMode.light) ? ThemeMode.dark : ThemeMode.light;
    _saveThemeMode(themeMode.value);
  }
}
