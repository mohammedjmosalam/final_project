part of '../single_post_template.dart';

class _AddAndViewComments extends StatelessWidget {
  const _AddAndViewComments({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SinglePostCubit, SinglePostState>(
      builder: (context, state) {
        return Column(
          children: [
            SizedBox(
              height: 4.h,
              child: Center(
                child: Container(
                  width: MediaQuery.sizeOf(context).width / 4,
                  height: 0.5.h,
                  color: Colors.red,
                ),
              ),
            ),
            SizedBox(
              height: 5.h,
              child: Row(
                children: [
                  const AppIcon(
                    icon: Icons.favorite,
                    iconColor: Colors.red,
                  ),
                  Flexible(
                    child: ListView.builder(
                      itemCount: state.postData.whoLikes.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final String? userName = state
                            .usersLikeAndComments[
                                state.postData.whoLikes.elementAt(index)]
                            ?.name;
                        return userName == null
                            ? const SizedBox()
                            : Container(
                                decoration: BoxDecoration(
                                  color: context.them.buttonColor,
                                  borderRadius: BorderRadius.circular(2.w),
                                  border: Border.all(
                                      color: context.them.iconAndTextColor),
                                ),
                                alignment: Alignment.center,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 3,
                                ),
                                margin: const EdgeInsets.all(5),
                                child: AppText(
                                  text: userName,
                                  textColor: Colors.white,
                                ),
                              );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                child: ListView.builder(
              itemCount: state.postData.comments.length,
              itemBuilder: (context, index) {
                CommentModel commentModel =
                    state.postData.comments.elementAt(index);
                UserApp? userApp =
                    state.usersLikeAndComments[commentModel.userId];
                return _SingleComment(
                  userApp: userApp,
                  commentContent: commentModel.commentContent,
                );
              },
            )),
            Row(
              children: [
                Expanded(
                  child: AppTextField(
                    textController: state.commentController,
                    hintText: context.lang.commentHint,
                  ),
                ),
                AppButton(
                  onTap: () => context.read<SinglePostCubit>().addComments(),
                  title: context.lang.comment,
                )
              ],
            )
          ],
        );
      },
    );
  }
}
