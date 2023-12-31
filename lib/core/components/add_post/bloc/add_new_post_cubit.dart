// ignore_for_file: use_build_context_synchronously

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:final_project/core/components/posts/bloc/posts_cubit.dart';
import 'package:final_project/data/data_helper/app_data.dart';
import 'package:final_project/data/model/post_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/api/firebase_databse_api.dart';
import '../../../../data/api/firebase_storge.dart';
import '../../../../data/model/reslut_api.dart';
import '../../../../data/repositorty/firebase_database.dart';
import '../../../../data/repositorty/firebase_storge.dart';
import '../../../enum/dialog_types.dart';

part 'add_new_post_state.dart';

class AddNewPostCubit extends Cubit<AddNewPostState> {
  final PostsCubit postsCubit;
  final PostModel? postEdit;

  AddNewPostCubit({
    required this.postsCubit,
    this.postEdit,
  }) : super(AddNewPostState(
          postContent: TextEditingController(
            text: postEdit?.contentPost,
          ),
          isEditPost: postEdit != null,
          images: postEdit?.images ?? [],
        ));
  Future<void> pickedPostImages() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.image,
    );

    if (result != null) {
      List<String> files = result.paths.map((path) => path!).toList();
      emit(state.copyWith(
        images: List.from(files),
      ));
    }
  }

  Future<void> addPost(BuildContext context) async {
    emit(state.copyWith(
      dialogsType: DialogsType.loading,
    ));
    FirebaseStorgRepo firebaseStorgRepo = FirebaseStorgRepo(
      firebaseStorgApi: FirebaseStorgApi(),
    );
    List<String> urlImages = postEdit?.images ?? [];
    DateTime dateTime = DateTime.now();
    String idUser =
        postEdit?.idUserPost ?? context.read<AppData>().currentUser!.idUser;
    String idPost = postEdit?.idPost ??
        dateTime.millisecondsSinceEpoch.toString() +
            idUser.substring(idUser.length - 4, idUser.length);
    if (!state.isEditPost) {
      for (var image in state.images) {
        ResultApi resultApi = await firebaseStorgRepo.uploadImage(
            context: context,
            imagePath: image,
            nameFolder: idPost,
            imageName: '${state.images.indexOf(image)}.jpg');
        if (!resultApi.isError) {
          String url = resultApi.value;
          urlImages.add(url);
        }
      }
    }

    final String contentPost = state.postContent.text.trim();
    PostModel postModel = PostModel(
      comments: postEdit?.comments ?? [],
      contentPost: contentPost,
      idUserPost: idUser,
      images: urlImages,
      whoLikes: postEdit?.whoLikes ?? [],
      idPost: idPost,
      datePost: postEdit?.datePost ??
          '${dateTime.year}-${dateTime.month}-${dateTime.day}',
      idDate: postEdit?.idDate ?? dateTime.millisecondsSinceEpoch,
    );
    FirebaseDataBase firebaseDataBase = FirebaseDataBase(
      FireBaseDatabaseApp(),
    );
    ResultApi resultApi = await firebaseDataBase.uploadData(
        collection: 'post',
        doc: idPost,
        dataUpload: postModel.toJson,
        context: context);
    if (resultApi.isError) {
      emit(state.copyWith(
        dialogsType: DialogsType.error,
        errorMassage: resultApi.value,
      ));
    } else {
      if (state.isEditPost) {
        postsCubit.editPost(postModel);
      } else {
        postsCubit.addNewPost(postModel);
      }
      emit(state.copyWith(
        dialogsType: DialogsType.successful,
      ));
    }
  }

  void restDialog() {
    emit(state.copyWith(
      dialogsType: DialogsType.init,
    ));
  }
}
