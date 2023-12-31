part of '../chatting.dart';

class _WriteMassage extends StatelessWidget {
  const _WriteMassage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChattingCubit, ChattingState>(
      buildWhen: (previous, current) => false,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: AppTextField(
                  textController: state.massageController,
                  hintText: context.lang.typingMassage,
                ),
              ),
              AppButton(
                  onTap: () => context.read<ChattingCubit>().sendMassage(),
                  title: context.lang.send)
            ],
          ),
        );
      },
    );
  }
}
