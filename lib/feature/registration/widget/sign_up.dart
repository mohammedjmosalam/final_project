part of '../restration.dart';

class _SignUp extends StatelessWidget {
  const _SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationCubit, RegistrationState>(
        buildWhen: (previous, current) => false,
        builder: (context, state) {
          return Form(
            key: state.keyForm,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppText(
                  text: context.lang.signUp,
                  fontSize: 20,
                ),
                AppTextField(
                  textController: state.nameController,
                  hintText: context.lang.name,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Zأ-ي]')),
                  ],
                  validate: (text) => context
                      .read<RegistrationCubit>()
                      .validateIsEmpty(
                          context: context,
                          value: text,
                          textFelidName: context.lang.name),
                  prefix: const AppIcon(
                    icon: Icons.person,
                  ),
                ),
                const EmailWidget(),
                const PasswordWidget(),
                AppTextField(
                  textController: state.birthDayController,
                  hintText: context.lang.birthDay,
                  isReadOnly: true,
                  onTap: () =>
                      context.read<RegistrationCubit>().onTapBirthDay(),
                  validate: (text) => context
                      .read<RegistrationCubit>()
                      .validateIsEmpty(
                          context: context,
                          value: text,
                          textFelidName: context.lang.birthDay),
                  prefix: const AppIcon(
                    icon: Icons.date_range_outlined,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 2.w,
                    vertical: 1.h,
                  ),
                  child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: context.them.iconAndTextColor,
                          ),
                          borderRadius: BorderRadius.circular(2.w),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: context.them.iconAndTextColor,
                          ),
                          borderRadius: BorderRadius.circular(2.w),
                        ),
                      ),
                      value: state.genderController.text,
                      validator: (text) => context
                          .read<RegistrationCubit>()
                          .validateIsEmpty(
                              context: context,
                              value: text,
                              textFelidName: context.lang.gender),
                      items: context
                          .read<RegistrationCubit>()
                          .gender
                          .map((e) => DropdownMenuItem(
                                value: e,
                                child: AppText(
                                  text: context
                                              .read<RegistrationCubit>()
                                              .gender
                                              .indexOf(e) ==
                                          0
                                      ? context.lang.male
                                      : context.lang.female,
                                ),
                              ))
                          .toList(),
                      onChanged: (e) => context
                          .read<RegistrationCubit>()
                          .onSelectedGender(e!)),
                ),
                AppButton(
                  onTap: () => context.read<RegistrationCubit>().signUp(
                        context: context,
                      ),
                  title: context.lang.signUp,
                ),
                RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: <TextSpan>[
                      TextSpan(
                        text: context.lang.haveAccount,
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: context.them.iconAndTextColor,
                        ),
                      ),
                      TextSpan(
                        text: context.lang.login,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () =>
                              context.read<RegistrationCubit>().movePagesCard(
                                    isLogin: false,
                                  ),
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: context.them.buttonColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
