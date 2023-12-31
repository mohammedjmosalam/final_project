part of '../post_view_and_show_posts.dart';

class _PostView extends StatelessWidget {
  const _PostView({super.key, required this.keyScaffold});
  final GlobalKey<ScaffoldState> keyScaffold;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostsCubit, PostsState>(
      builder: (context, state) {
        switch (state.getPostState) {
          case DialogsType.loading:
            return Center(
              child: CircularProgressIndicator(color: context.them.buttonColor),
            );
          case DialogsType.error:
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AppText(text: state.errorMassage),
                IconButton(
                  onPressed: () => context.read<PostsCubit>().getListPost(),
                  icon: const AppIcon(icon: Icons.refresh),
                )
              ],
            );
          case DialogsType.successful:
            return ListView.builder(
              itemCount: state.posts.length,
              itemBuilder: (context, index) {
                PostModel post = state.posts.elementAt(index);
                return SinglePostView(
                  postModel: post,
                  keyScaffold: keyScaffold,
                );
              },
            );

          default:
            return Center(
              child: CircularProgressIndicator(color: context.them.buttonColor),
            );
        }
      },
    );
  }
}
