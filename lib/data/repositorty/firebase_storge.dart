// ignore_for_file: use_build_context_synchronously

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:final_project/core/extension/context.dart';
import 'package:final_project/data/model/reslut_api.dart';
import 'package:flutter/material.dart';

import '../api/firebase_storge.dart';

class FirebaseStorgRepo {
  final FirebaseStorgApi firebaseStorgApi;
  FirebaseStorgRepo({required this.firebaseStorgApi});
  Future<ResultApi> uploadImage({
    required BuildContext context,
    required String imagePath,
    required String nameFolder,
    required String imageName,
  }) async {
    if (await isConnectedNetwork()) {
      try {
        final ResultApi resultApi = await firebaseStorgApi.uploadImage(
            context: context,
            imagePath: imagePath,
            nameFolder: nameFolder,
            imageName: imageName);
        return resultApi;
      } catch (e) {
        return ResultApi(isError: true, value: e.toString());
      }
    } else {
      return ResultApi(isError: true, value: context.lang.noInternetAccess);
    }
  }

  Future<ResultApi> removeImage({
    required BuildContext context,
    required String nameFolder,
    required int lengthImages,
  }) async {
    if (await isConnectedNetwork()) {
      try {
        final ResultApi resultApi = await firebaseStorgApi.removeImage(
          context: context,
          nameFolder: nameFolder,
          lengthImages: lengthImages,
        );
        return resultApi;
      } catch (e) {
        return ResultApi(isError: true, value: e.toString());
      }
    } else {
      return ResultApi(isError: true, value: context.lang.noInternetAccess);
    }
  }

  Future<bool> isConnectedNetwork() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    } else {
      return true;
    }
  }
}
