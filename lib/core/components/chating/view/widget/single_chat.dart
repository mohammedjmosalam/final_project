part of '../chatting.dart';

class _SingleChatView extends StatelessWidget {
  const _SingleChatView({
    super.key,
    required this.chatModel,
  });
  final ChatModel chatModel;

  @override
  Widget build(BuildContext context) {
    final currentUser = context.read<AppData>().currentUser!;
    final toUser = context.read<ChattingCubit>().userChat;
    bool fromUser = chatModel.fromUserId == currentUser.idUser;
    UserApp selectedUser = fromUser ? currentUser : toUser;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        textDirection: fromUser ? TextDirection.ltr : TextDirection.rtl,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            textDirection: fromUser ? TextDirection.ltr : TextDirection.rtl,
            children: [
              CircleAvatar(
                radius: 6.w,
                backgroundColor: Colors.red.shade100,
                backgroundImage: selectedUser.imagePerson != null
                    ? NetworkImage(selectedUser.imagePerson!)
                    : null,
                child: selectedUser.imagePerson != null
                    ? null
                    : const Center(
                        child: AppIcon(
                          icon: Icons.person,
                        ),
                      ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppText(text: selectedUser.name),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: AppText(text: chatModel.contentMassage),
          )
        ],
      ),
    );
  }
}
