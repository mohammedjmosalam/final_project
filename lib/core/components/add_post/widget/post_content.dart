part of '../add_post.dart';

class _PostContent extends StatelessWidget {
  const _PostContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddNewPostCubit, AddNewPostState>(
      buildWhen: (previous, current) => false,
      builder: (context, state) {
        return AppTextField(
          textController: state.postContent,
          colorBorder: context.them.iconAndTextColor.withOpacity(0.1),
          hintText: context.lang.addPost,
          maxLine: 5,
        );
      },
    );
  }
}
