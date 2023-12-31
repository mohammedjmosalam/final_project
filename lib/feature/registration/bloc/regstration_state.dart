part of 'regstration_cubit.dart';

class RegistrationState extends Equatable {
  const RegistrationState({
    this.isLogin = true,
    required this.cardRegistrationController,
    required this.emailController,
    required this.passwordController,
    required this.birthDayController,
    required this.genderController,
    required this.nameController,
    required this.keyForm,
    this.isShowPassword = true,
    this.dialogsType = DialogsType.init,
    this.errorMassage = '',
  });
  final bool isLogin;
  final SwiperController cardRegistrationController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController nameController;
  final TextEditingController genderController;
  final TextEditingController birthDayController;
  final bool isShowPassword;
  final GlobalKey<FormState> keyForm;
  final DialogsType dialogsType;
  final String errorMassage;

  RegistrationState copyWith({
    bool? isLogin,
    SwiperController? cardRegistrationController,
    TextEditingController? passwordController,
    TextEditingController? emailController,
    TextEditingController? nameController,
    TextEditingController? genderController,
    TextEditingController? birthDayController,
    bool? isShowPassword,
    GlobalKey<FormState>? keyForm,
    DialogsType? dialogsType,
    String? errorMassage,
  }) =>
      RegistrationState(
          isLogin: isLogin ?? this.isLogin,
          errorMassage: errorMassage ?? this.errorMassage,
          dialogsType: dialogsType ?? this.dialogsType,
          cardRegistrationController:
              cardRegistrationController ?? this.cardRegistrationController,
          emailController: emailController ?? this.emailController,
          passwordController: passwordController ?? this.passwordController,
          isShowPassword: isShowPassword ?? this.isShowPassword,
          keyForm: keyForm ?? this.keyForm,
          birthDayController: birthDayController ?? this.birthDayController,
          nameController: nameController ?? this.nameController,
          genderController: genderController ?? this.genderController);

  @override
  List<Object> get props => [
        isLogin,
        birthDayController,
        nameController,
        genderController,
        cardRegistrationController,
        emailController,
        passwordController,
        isShowPassword,
        keyForm,
        dialogsType,
        errorMassage,
      ];
}
