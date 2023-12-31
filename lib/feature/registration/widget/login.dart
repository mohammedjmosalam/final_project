part of '../restration.dart';

class _Login extends StatelessWidget {
  const _Login({super.key});

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
                text: context.lang.login,
                fontSize: 20,
              ),
              const EmailWidget(),
              const PasswordWidget(),
              AppButton(
                onTap: () => context.read<RegistrationCubit>().login(
                      context: context,
                    ),
                title: context.lang.login,
              ),
              RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(
                      text: context.lang.notHaveAccount,
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: context.them.iconAndTextColor,
                      ),
                    ),
                    TextSpan(
                      text: context.lang.signUp,
                      recognizer: TapGestureRecognizer()
                        ..onTap = () =>
                            context.read<RegistrationCubit>().movePagesCard(
                                  isLogin: true,
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
      },
    );
  }
}
