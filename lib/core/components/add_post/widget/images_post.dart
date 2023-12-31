part of '../add_post.dart';

class _ImageAddPost extends StatelessWidget {
  const _ImageAddPost({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddNewPostCubit, AddNewPostState>(
      buildWhen: (previous, current) => previous.images != current.images,
      builder: (context, state) {
        if (state.images.isEmpty && !state.isEditPost) {
          return Center(
            child: IconButton(
              onPressed: () =>
                  context.read<AddNewPostCubit>().pickedPostImages(),
              icon: Icon(
                Icons.add_a_photo_outlined,
                color: context.them.iconAndTextColor,
              ),
            ),
          );
        } else if (state.images.isEmpty && state.isEditPost) {
          return Center(
            child: AppText(text: context.lang.noImage),
          );
        }
        return ListView.builder(
          itemCount: state.images.length + (state.isEditPost ? 0 : 1),
          itemBuilder: (context, index) {
            return index == state.images.length
                ? IconButton(
                    onPressed: () =>
                        context.read<AddNewPostCubit>().pickedPostImages(),
                    icon: Icon(
                      Icons.add_a_photo_outlined,
                      color: context.them.iconAndTextColor,
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: state.isEditPost
                        ? Image.network(state.images.elementAt(index))
                        : Image.file(File(state.images.elementAt(index))),
                  );
          },
        );
      },
    );
  }
}
