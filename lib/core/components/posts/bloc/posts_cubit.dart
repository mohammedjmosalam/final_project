import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:final_project/core/enum/dialog_types.dart';
import 'package:final_project/data/model/post_model.dart';
import 'package:final_project/data/model/reslut_api.dart';
import 'package:final_project/data/model/user_app.dart';
import 'package:final_project/data/repositorty/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../../enum/navigat_post.dart';

part 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  final FirebaseDataBase firebaseDataBase;
  final BuildContext context;
  final bool fromProfile;
  final UserApp? userApp;
  PostsCubit({
    required this.firebaseDataBase,
    required this.context,
    required this.fromProfile,
    required this.userApp,
  }) : super(const PostsState()) {
    getListPost(
      formConstructor: true,
    );
  }
  void navigatePost(NavigatePost navigatePost, {PostModel? post}) {
    emit(state.copyWith(
      navigatePost: navigatePost,
      postEdit: post,
    ));
  }

  Future<void> getListPost({
    bool formConstructor = false,
  }) async {
    if (!formConstructor) {
      emit(state.copyWith(
        getPostState: DialogsType.loading,
      ));
    }
    ResultApi result = await firebaseDataBase.getMultiData(
      collection: 'post',
      context: context,
      userId: userApp?.idUser,
    );
    if (result.isError) {
      emit(state.copyWith(
        getPostState: DialogsType.error,
        errorMassage: result.value,
      ));
    } else {
      emit(state.copyWith(
          posts: List.from(result.value),
          getPostState: DialogsType.successful));
    }
  }

  void removePostFromId(String id) {
    List<PostModel> posts = List.from(state.posts);
    posts.removeWhere((element) => element.idPost == id);
    emit(state.copyWith(
      posts: posts,
    ));
  }

  void addNewPost(PostModel post) {
    List<PostModel> posts = List.from(state.posts);
    posts.add(post);
    emit(state.copyWith(
      posts: posts,
    ));
  }

  void editPost(PostModel post) {
    List<PostModel> posts = List.from(state.posts);
    posts.removeWhere((element) => element.idPost == post.idPost);
    posts.add(post);
    emit(state.copyWith(
      posts: posts,
    ));
  }

  void restNavigatorPost() {
    emit(state.copyWith(
      navigatePost: NavigatePost.inti,
    ));
  }
}
