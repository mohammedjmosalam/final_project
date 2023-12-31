import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'app_controller_state.dart';

class AppControllerCubit extends Cubit<AppControllerState> {
  AppControllerCubit() : super(const AppControllerState());
  void changeLang(Locale newLang) {
    emit(state.copyWith(
      appLang: newLang,
    ));
  }

  void changeTheme(Brightness newTheme) {
    emit(state.copyWith(
      appTheme: newTheme,
    ));
  }
}
