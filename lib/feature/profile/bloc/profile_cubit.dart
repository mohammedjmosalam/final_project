// ignore_for_file: use_build_context_synchronously

import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:final_project/core/enum/dialog_types.dart';
import 'package:final_project/data/api/firebase_databse_api.dart';
import 'package:final_project/data/api/firebase_storge.dart';
import 'package:final_project/data/data_helper/app_data.dart';
import 'package:final_project/data/model/reslut_api.dart';
import 'package:final_project/data/model/user_app.dart';
import 'package:final_project/data/repositorty/firebase_database.dart';
import 'package:final_project/data/repositorty/firebase_storge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final UserApp userApp;
  final BuildContext context;
  ProfileCubit({
    required this.context,
    required this.userApp,
  }) : super(
          ProfileState(
              userApp: userApp,
              nameController: TextEditingController(),
              isCurrentUserProfile: userApp.idUser ==
                  context.read<AppData>().currentUser!.idUser),
        );
  Future<void> changeImageProfile() async {
    FilePickerResult? filePickerResult = await FilePicker.platform
        .pickFiles(allowMultiple: false, type: FileType.image);
    if (filePickerResult != null) {
      emit(state.copyWith(
        dialogsType: DialogsType.loading,
      ));
      String imagePath = filePickerResult.files.first.path!;
      FirebaseStorgRepo firebaseStorgRepo = FirebaseStorgRepo(
        firebaseStorgApi: FirebaseStorgApi(),
      );
      var reslutApi = await firebaseStorgRepo.uploadImage(
          context: context,
          imagePath: imagePath,
          nameFolder: 'Users',
          imageName: state.userApp.idUser);
      if (!reslutApi.isError) {
        String imageUrl = reslutApi.value;
        UserApp userApp = state.userApp.copyWith(imagePerson: imageUrl);
        ResultApi resultApi = await FirebaseDataBase(FireBaseDatabaseApp())
            .uploadData(
                collection: 'Users',
                doc: state.userApp.idUser,
                dataUpload: userApp.toJson(),
                context: context);
        if (!resultApi.isError) {
          context.read<AppData>().setUser = userApp;
          emit(state.copyWith(
            userApp: userApp,
            dialogsType: DialogsType.successful,
          ));
        } else {
          emit(state.copyWith(
            dialogsType: DialogsType.error,
            errorMassage: resultApi.value,
          ));
        }
      } else {
        emit(state.copyWith(
          dialogsType: DialogsType.error,
          errorMassage: reslutApi.value,
        ));
      }
    }
  }

  void onTapChangeName() {
    emit(state.copyWith(
      nameController: TextEditingController(text: state.userApp.name),
      isShowEditName: !state.isShowEditName,
    ));
  }

  Future<void> changeName() async {
    if (state.isShowEditName) {
      String newName = state.nameController.text.trim();
      if (newName.isNotEmpty) {
        emit(state.copyWith(
          dialogsType: DialogsType.loading,
        ));
        UserApp userApp = state.userApp.copyWith(name: newName);
        ResultApi resultApi = await FirebaseDataBase(FireBaseDatabaseApp())
            .uploadData(
                collection: 'Users',
                doc: state.userApp.idUser,
                dataUpload: userApp.toJson(),
                context: context);
        if (!resultApi.isError) {
          context.read<AppData>().setUser = userApp;
          emit(state.copyWith(
            userApp: userApp,
            dialogsType: DialogsType.successful,
          ));
        } else {
          emit(state.copyWith(
            dialogsType: DialogsType.error,
            errorMassage: resultApi.value,
          ));
        }
      }
    }
    onTapChangeName();
  }

  void restDialog() {
    emit(state.copyWith(dialogsType: DialogsType.init, errorMassage: ''));
  }
}
