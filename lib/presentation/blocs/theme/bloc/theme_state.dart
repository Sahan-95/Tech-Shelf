part of 'theme_bloc.dart';

@immutable
sealed class ThemeState {}

final class ThemeInitial extends ThemeState {}

// Light mode
final class ThemeLight extends ThemeState {
  final ThemeData themeData = ThemeData.light();
}

// Dark mode
final class ThemeDark extends ThemeState {
  final ThemeData themeData = ThemeData.dark();
}
