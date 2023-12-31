part of '../../restration.dart';

class EmailWidget extends StatelessWidget {
  const EmailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationCubit, RegistrationState>(
      buildWhen: (previous, current) => false,
      builder: (context, state) {
        return AppTextField(
          textController: state.emailController,
          hintText: context.lang.email,
          validate: (text) => context
              .read<RegistrationCubit>()
              .validateEmail(context: context, email: text),
          prefix: const AppIcon(
            icon: Icons.email,
          ),
        );
      },
    );
  }
}
