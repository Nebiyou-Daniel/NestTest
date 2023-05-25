import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/Theme/bloc/theme_event.dart';
import 'package:frontend/Theme/bloc/theme_state.dart';
<<<<<<< HEAD
import '../app_themes.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(const ThemeState(theme: AppTheme.LightTheme)) {
    on<ThemeChangedEvent>((event, emit) {
      emit(ThemeState(theme: event.theme));
=======

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(LightTheme()) {
    on<ThemeChangedEvent>((event, emit) {
      if (event.isDarkThemeOn) {
        emit(DarkTheme());
      } else {
        emit(LightTheme());
      }
>>>>>>> Nathnael-Dereje
    });
  }
}
