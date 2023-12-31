// ignore_for_file: use_build_context_synchronously

import 'package:equatable/equatable.dart';
import 'package:final_project/data/data_helper/app_data.dart';
import 'package:final_project/data/model/user_app.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/enum/navigator_splash.dart';
import '../../../data/api/firebase_databse_api.dart';
import '../../../data/repositorty/firebase_database.dart';

part 'splash_screen_state.dart';

class SplashScreenCubit extends Cubit<SplashScreenState> {
  final BuildContext context;
  SplashScreenCubit({
    required this.context,
  }) : super(const SplashScreenState()) {
    autoLogin();
  }
  Future<void> autoLogin() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    if (firebaseAuth.currentUser != null) {
      FirebaseDataBase firebaseDataBase = FirebaseDataBase(
        FireBaseDatabaseApp(),
      );
      var result = await firebaseDataBase.getData(
          collection: 'Users',
          doc: firebaseAuth.currentUser!.uid,
          context: context);
      if (result.isError) {
        emit(state.copyWith(
          navigatorSplash: NavigatorSplash.registration,
          error: result.value,
        ));
      } else {
        emit(state.copyWith(
          navigatorSplash: NavigatorSplash.home,
        ));
        UserApp userApp = UserApp.fromJson(result.value);
        context.read<AppData>().setUser = userApp;
      }
    } else {
      await Future.delayed(const Duration(seconds: 1));
      emit(state.copyWith(
        navigatorSplash: NavigatorSplash.registration,
      ));
    }
  }
}
