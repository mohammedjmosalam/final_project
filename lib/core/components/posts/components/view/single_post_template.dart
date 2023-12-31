import 'package:final_project/config/route/app_route.dart';
import 'package:final_project/core/components/posts/components/bloc/single_post_cubit.dart';
import 'package:final_project/core/custom_widget/app_button.dart';
import 'package:final_project/core/custom_widget/app_icon.dart';
import 'package:final_project/core/custom_widget/app_text.dart';
import 'package:final_project/core/custom_widget/app_text_form_field.dart';
import 'package:final_project/core/extension/context.dart';
import 'package:final_project/core/extension/theme.dart';
import 'package:final_project/data/api/firebase_databse_api.dart';
import 'package:final_project/data/data_helper/app_data.dart';
import 'package:final_project/data/model/comment.dart';
import 'package:final_project/data/model/post_model.dart';
import 'package:final_project/data/model/user_app.dart';
import 'package:final_project/data/repositorty/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
part 'widget/conments_widget.dart';
part 'widget/singl_comment.dart';

class SinglePostView extends StatelessWidget {
  const SinglePostView({
    super.key,
    required this.postModel,
    required this.keyScaffold,
  });
  final PostModel postModel;
  final GlobalKey<ScaffoldState> keyScaffold;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SinglePostCubit>(
      create: (contextB) => SinglePostCubit(
        firebaseDataBase: FirebaseDataBase(FireBaseDatabaseApp()),
        context: context,
        postModel: postModel,
        keyScaffold: keyScaffold,
      ),
      child: BlocBuilder<SinglePostCubit, SinglePostState>(
        buildWhen: (previous, current) => previous.userApp != current.userApp,
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  textDirection: TextDirection.ltr,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        if (state.userApp != null) {
                          Navigator.pushNamed(context, AppRoute.profile,
                              arguments: [state.userApp]);
                        }
                      },
                      child: Row(
                        textDirection: TextDirection.ltr,
                        children: [
                          CircleAvatar(
                            radius: 6.w,
                            backgroundColor: Colors.red.shade100,
                            backgroundImage: state.userApp?.imagePerson != null
                                ? NetworkImage(state.userApp!.imagePerson!)
                                : null,
                            child: state.userApp?.imagePerson != null
                                ? null
                                : const Center(
                                    child: AppIcon(
                                      icon: Icons.person,
                                    ),
                                  ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AppText(
                                text: state.userApp?.name ?? 'Un know person'),
                          ),
                        ],
                      ),
                    ),
                    if (state.userApp?.idUser ==
                        context.read<AppData>().currentUser!.idUser)
                      PopupMenuButton(
                        child: const AppIcon(icon: Icons.more_vert),
                        onSelected: (value) => context
                            .read<SinglePostCubit>()
                            .editOrDeletePost(value),
                        itemBuilder: (context) {
                          return const [
                            PopupMenuItem(
                              value: 'Edit',
                              child: AppText(text: 'Edit post'),
                            ),
                            PopupMenuItem(
                              value: 'Delete',
                              child: AppText(
                                text: 'Delete post',
                              ),
                            ),
                          ];
                        },
                      )
                    else
                      const SizedBox(),
                  ],
                ),
                if (postModel.images.isNotEmpty)
                  SizedBox(
                    height: 20.h,
                    child: ListView.builder(
                      itemCount: postModel.images.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:
                              Image.network(postModel.images.elementAt(index)),
                        );
                      },
                    ),
                  ),
                Row(
                  children: [
                    BlocSelector<SinglePostCubit, SinglePostState, bool>(
                        selector: (state) => state.isLikePost,
                        builder: (context, isLikePost) {
                          return IconButton(
                            onPressed: () => context
                                .read<SinglePostCubit>()
                                .likePost(isLikePost),
                            icon: AppIcon(
                              icon: isLikePost
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              iconColor: Colors.red,
                            ),
                          );
                        }),
                    IconButton(
                        onPressed: () {
                          keyScaffold.currentState!.showBottomSheet(
                            backgroundColor: context.them.backgroundAppColor,
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                              color: context.them.iconAndTextColor,
                            )),
                            constraints: BoxConstraints(
                                maxHeight: 50.h, minHeight: 20.h),
                            (contextB) => BlocProvider.value(
                              value: context.read<SinglePostCubit>(),
                              child: const _AddAndViewComments(),
                            ),
                          );
                        },
                        icon: const AppIcon(
                          icon: Icons.chat_bubble_outline,
                        ))
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AppText(text: postModel.contentPost),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
