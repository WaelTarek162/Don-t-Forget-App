import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
class ThemeServices {


  final GetStorage _box = GetStorage();
  final _key ='isDarkMode';

  _saveThemeToBox(bool isDarkMode)=>_box.write(_key, isDarkMode);

  bool _loadThemeFromBox()=>_box.read<bool>(_key)??false;

  ThemeMode get theme=>_loadThemeFromBox()?ThemeMode.dark:ThemeMode.light;

  void switch_theme(){
    Get.changeThemeMode(_loadThemeFromBox()?ThemeMode.dark:ThemeMode.light); //changing the theme
    _saveThemeToBox(!_loadThemeFromBox()); // save new value in storage
  }

}
