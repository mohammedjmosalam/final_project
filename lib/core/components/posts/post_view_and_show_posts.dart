import 'package:final_project/config/route/app_route.dart';
import 'package:final_project/core/components/posts/bloc/posts_cubit.dart';
import 'package:final_project/core/custom_widget/app_icon.dart';
import 'package:final_project/core/custom_widget/app_text.dart';
import 'package:final_project/core/custom_widget/app_text_form_field.dart';
import 'package:final_project/core/enum/dialog_types.dart';
import 'package:final_project/core/enum/navigat_post.dart';
import 'package:final_project/core/extension/context.dart';
import 'package:final_project/core/extension/theme.dart';
import 'package:final_project/data/api/firebase_databse_api.dart';
import 'package:final_project/data/data_helper/app_data.dart';
import 'package:final_project/data/model/post_model.dart';
import 'package:final_project/data/model/user_app.dart';
import 'package:final_project/data/repositorty/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'components/view/single_post_template.dart';
part 'widget/add_post.dart';
part 'widget/post_view.dart';

class AddPostAndPostsView extends StatelessWidget {
  const AddPostAndPostsView({
    super.key,
    required this.keyScaffold,
    this.fromProfile = false,
    this.userApp,
  });
  final GlobalKey<ScaffoldState> keyScaffold;
  final bool fromProfile;
  final UserApp? userApp;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PostsCubit>(
      create: (contextB) => PostsCubit(
        fromProfile: fromProfile,
        userApp: userApp,
        context: context,
        firebaseDataBase: FirebaseDataBase(FireBaseDatabaseApp()),
      ),
      child: Builder(builder: (context) {
        return BlocListener<PostsCubit, PostsState>(
          listener: (contextB, state) {
            switch (state.navigatePost) {
              case NavigatePost.addNewPost:
              case NavigatePost.editPost:
                Navigator.pushNamed(
                  context,
                  AppRoute.addPost,
                  arguments: [
                    context.read<PostsCubit>(),
                    if (NavigatePost.editPost == state.navigatePost)
                      state.postEdit,
                  ],
                ).whenComplete(
                    () => context.read<PostsCubit>().restNavigatorPost());

                break;
              default:
            }
          },
          listenWhen: (previous, current) =>
              previous.navigatePost != current.navigatePost,
          child: Column(
            children: [
              if (userApp?.idUser ==
                      context.read<AppData>().currentUser!.idUser ||
                  userApp == null)
                const _AddPost(),
              Expanded(child: _PostView(keyScaffold: keyScaffold)),
            ],
          ),
        );
      }),
    );
  }
}
