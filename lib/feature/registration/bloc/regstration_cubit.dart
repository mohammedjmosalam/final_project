// ignore_for_file: use_build_context_synchronously

import 'package:card_swiper/card_swiper.dart';
import 'package:equatable/equatable.dart';
import 'package:final_project/data/data_helper/app_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/enum/dialog_types.dart';
import '../../../data/model/reslut_api.dart';
import '../../../data/repositorty/fireabse_auth.dart';
import '../data_helper/validate.dart';

part 'regstration_state.dart';

class RegistrationCubit extends Cubit<RegistrationState>
    with RegistrationValidate {
  final FirebaseAuthApp firebaseAuthApp;
  final List<String> gender;
  RegistrationCubit({
    required this.firebaseAuthApp,
    this.gender = const [
      'male',
      'female',
    ],
  }) : super(
          RegistrationState(
            cardRegistrationController: SwiperController(),
            emailController: TextEditingController(),
            passwordController: TextEditingController(),
            birthDayController: TextEditingController(),
            genderController: TextEditingController(
              text: 'male',
            ),
            nameController: TextEditingController(),
            keyForm: GlobalKey<FormState>(),
          ),
        );
  void showHidePassword() {
    emit(state.copyWith(
      isShowPassword: !state.isShowPassword,
    ));
  }

  void movePagesCard({required bool isLogin}) {
    emit(state.copyWith(
      emailController: TextEditingController(),
      passwordController: TextEditingController(),
      keyForm: GlobalKey<FormState>(),
    ));
    state.cardRegistrationController.move(isLogin ? 1 : 0, animation: true);
  }

  Future<void> login({required BuildContext context}) async {
    if (state.keyForm.currentState!.validate()) {
      emit(state.copyWith(dialogsType: DialogsType.loading));
      final String email = state.emailController.text.trim();
      final String password = state.passwordController.text.trim();
      ResultApi resultApi = await firebaseAuthApp.login(
          context: context, email: email, password: password);
      if (resultApi.isError) {
        emit(state.copyWith(
          errorMassage: resultApi.value,
          dialogsType: DialogsType.error,
        ));
      } else {
        context.read<AppData>().setUser = resultApi.value;
        emit(state.copyWith(
          dialogsType: DialogsType.successful,
        ));
      }
    }
  }

  void restDialog() {
    emit(state.copyWith(
      dialogsType: DialogsType.init,
      errorMassage: '',
    ));
  }

  void onTapBirthDay() {
    emit(state.copyWith(
      dialogsType: DialogsType.showDatePicker,
    ));
  }

  void onSelectedDate({required DateTime? date}) {
    emit(state.copyWith(
      dialogsType: DialogsType.init,
    ));
    if (date != null) {
      String dateString = '${date.year}-${date.month}-${date.day}';
      state.birthDayController.text = dateString;
    }
  }

  void onSelectedGender(String gender) {
    state.genderController.text = gender;
  }

  Future<void> signUp({required BuildContext context}) async {
    if (state.keyForm.currentState!.validate()) {
      final String name = state.nameController.text.trim();
      final String email = state.emailController.text.trim();
      final String password = state.passwordController.text.trim();
      final String date = state.birthDayController.text.trim();
      final String gender = state.genderController.text.trim();
      emit(state.copyWith(dialogsType: DialogsType.loading));

      ResultApi resultApi = await firebaseAuthApp.signUp(
        context: context,
        birthday: date,
        email: email,
        password: password,
        gender: gender,
        name: name,
      );
      if (resultApi.isError) {
        emit(state.copyWith(
          errorMassage: resultApi.value,
          dialogsType: DialogsType.error,
        ));
      } else {
        context.read<AppData>().setUser = resultApi.value;
        emit(state.copyWith(
          dialogsType: DialogsType.successful,
        ));
      }
    }
  }
}
