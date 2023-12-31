part of '../chatting.dart';

class _ChattingMassage extends StatelessWidget {
  const _ChattingMassage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChattingCubit, ChattingState>(
        buildWhen: (previous, current) =>
            previous.streamChattingController !=
            current.streamChattingController,
        builder: (context, state) {
          return StreamBuilder(
            stream: state.streamChattingController.stream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: AppText(text: snapshot.error.toString() as String),
                );
              } else if (snapshot.hasData) {
                List<ChatModel> chates = snapshot.data!;
                chates.sort(
                  (a, b) => a.idDate.compareTo(b.idDate),
                );
                return ListView.builder(
                  itemCount: chates.length,
                  itemBuilder: (context, index) {
                    ChatModel chatModel = chates.elementAt(index);
                    return _SingleChatView(
                      chatModel: chatModel,
                    );
                  },
                );
              }
              return Center(
                child: CircularProgressIndicator(
                  color: context.them.buttonColor,
                ),
              );
            },
          );
        });
  }
}
