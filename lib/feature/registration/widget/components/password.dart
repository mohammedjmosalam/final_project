part of '../../restration.dart';

class PasswordWidget extends StatelessWidget {
  const PasswordWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationCubit, RegistrationState>(
      buildWhen: (previous, current) =>
          previous.isShowPassword != current.isShowPassword,
      builder: (context, state) {
        return AppTextField(
          textController: state.passwordController,
          hintText: context.lang.password,
          isShowContent: state.isShowPassword,
          prefix: const AppIcon(icon: Icons.key),
          validate: (password) => context
              .read<RegistrationCubit>()
              .validatePassword(context: context, password: password),
          suffix: IconButton(
            onPressed: () =>
                context.read<RegistrationCubit>().showHidePassword(),
            icon: AppIcon(
              icon: !state.isShowPassword
                  ? Icons.visibility_off
                  : Icons.visibility,
            ),
          ),
        );
      },
    );
  }
}
