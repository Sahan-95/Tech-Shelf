import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeInitial()) {
    on<ToggleTheme>((event, emit) {
      if (state is ThemeLight) {
        emit(ThemeDark());
      } else {
        emit(ThemeLight());
      }
    });
  }
}
