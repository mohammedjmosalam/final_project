// ignore_for_file: use_build_context_synchronously

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:final_project/core/components/posts/bloc/posts_cubit.dart';
import 'package:final_project/data/api/firebase_storge.dart';
import 'package:final_project/data/data_helper/app_data.dart';
import 'package:final_project/data/model/comment.dart';
import 'package:final_project/data/model/post_model.dart';
import 'package:final_project/data/model/reslut_api.dart';
import 'package:final_project/data/model/user_app.dart';
import 'package:final_project/data/repositorty/firebase_database.dart';
import 'package:final_project/data/repositorty/firebase_storge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../enum/navigat_post.dart';

part 'single_post_state.dart';

class SinglePostCubit extends Cubit<SinglePostState> {
  final FirebaseDataBase firebaseDataBase;
  final BuildContext context;

  final GlobalKey<ScaffoldState> keyScaffold;

  SinglePostCubit({
    required this.firebaseDataBase,
    required this.context,
    required this.keyScaffold,
    required PostModel postModel,
  }) : super(SinglePostState(
          postData: postModel,
          commentController: TextEditingController(),
        )) {
    initData();
  }
  Future<void> initData() async {
    bool isLike = state.postData.whoLikes
        .contains(context.read<AppData>().currentUser!.idUser);
    Set<String> usersId = Set.from(state.postData.whoLikes);
    List<String> usersIdComments =
        state.postData.comments.map((e) => e.userId).toList();
    usersId.addAll(usersIdComments);
    ResultApi allUserResult = await firebaseDataBase.getDataFromList(
      collection: 'Users',
      context: context,
      listData: List.from(usersId),
    );
    UserApp? userData = await getUserData();
    Map<String, UserApp> usersApp = {};
    if (!allUserResult.isError) {
      List<UserApp> users = List.from(allUserResult.value);
      for (var element in users) {
        usersApp[element.idUser] = element;
      }
    }
    usersApp[context.read<AppData>().currentUser!.idUser] =
        context.read<AppData>().currentUser!;
    emit(state.copyWith(
      isLikePost: isLike,
      userApp: userData,
      usersLikeAndComments: usersApp,
    ));
  }

  Future<UserApp?> getUserData() async {
    ResultApi result = await firebaseDataBase.getData(
        collection: 'Users', doc: state.postData.idUserPost, context: context);
    if (!result.isError) {
      return UserApp.fromJson(result.value);
    }
    return null;
  }

  Future<void> likePost(bool isLike) async {
    List<String> whoLikes = List.from(state.postData.whoLikes);
    if (isLike) {
      whoLikes.remove(context.read<AppData>().currentUser!.idUser);
    } else {
      whoLikes.add(context.read<AppData>().currentUser!.idUser);
    }
    PostModel postModel = state.postData.copy(
      whoLikes: List.from(whoLikes),
    );
    emit(state.copyWith(
      isLikePost: !state.isLikePost,
      postData: postModel,
    ));
    ResultApi result = await firebaseDataBase.uploadData(
      collection: 'post',
      doc: state.postData.idPost,
      context: context,
      dataUpload: postModel.toJson,
    );
    if (result.isError) {
      print(result.value);
    }
  }

  Future<void> addComments() async {
    List<CommentModel> comments = List.from(state.postData.comments);
    CommentModel commentModel = CommentModel(
        commentContent: state.commentController.text.trim(),
        userId: context.read<AppData>().currentUser!.idUser);
    comments.add(commentModel);
    PostModel postModel = state.postData.copy(
      comments: List.from(comments),
    );
    emit(state.copyWith(
      postData: postModel,
    ));
    state.commentController.clear();
    ResultApi result = await firebaseDataBase.uploadData(
      collection: 'post',
      doc: state.postData.idPost,
      context: context,
      dataUpload: postModel.toJson,
    );
    if (result.isError) {
      print(result.value);
    }
  }

  Future<void> editOrDeletePost(String value) async {
    if (value == 'Delete') {
      FirebaseStorgRepo firebaseStorgRepo = FirebaseStorgRepo(
        firebaseStorgApi: FirebaseStorgApi(),
      );
      ResultApi resultApi = await firebaseStorgRepo.removeImage(
        context: context,
        nameFolder: state.postData.idPost,
        lengthImages: state.postData.images.length,
      );
      if (!resultApi.isError) {
        ResultApi resultApiPost = await firebaseDataBase.removeDoc(
          collection: 'post',
          context: context,
          doc: state.postData.idPost,
        );
        if (!resultApiPost.isError) {
          context.read<PostsCubit>().removePostFromId(state.postData.idPost);
        }
      }
    } else {
      context
          .read<PostsCubit>()
          .navigatePost(NavigatePost.editPost, post: state.postData);
    }
  }
}
