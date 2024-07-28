import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:spisok_pokupok/Theme/repositories/theme_settings.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit({required ThemeInterf interf})
      : _interf = interf,
        super(const ThemeState(Brightness.light)) {
    _checkSelectedTheme();
  }

  final ThemeInterf _interf;

  Future<void> setThemBrigth(Brightness bright) async {
    try {
      emit(ThemeState(bright));
      await _interf.setDarkThemeSelected(bright == Brightness.dark);
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  void _checkSelectedTheme() {
    try {
      final bright = _interf.isDarkTheme() ? Brightness.dark : Brightness.light;
      emit(ThemeState(bright));
    } on Exception catch (e) {
      log(e.toString());
    }
  }
}
