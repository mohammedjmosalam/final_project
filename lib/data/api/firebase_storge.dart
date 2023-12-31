// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:final_project/core/extension/context.dart';
import 'package:final_project/data/model/reslut_api.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class FirebaseStorgApi {
  Future<ResultApi> uploadImage({
    required BuildContext context,
    required String imagePath,
    required String nameFolder,
    required String imageName,
  }) async {
    try {
      final storageRef = FirebaseStorage.instance.ref();

      Reference? imagesRef = storageRef.child(nameFolder);

      final spaceRef = imagesRef.child(imageName);
      UploadTask uploadTask = spaceRef.putFile(File(imagePath));
      await uploadTask.whenComplete(() => null);
      String imageUrl = await spaceRef.getDownloadURL();
      return ResultApi(isError: false, value: imageUrl);
    } catch (e) {
      throw context.lang.someErrorAccords;
    }
  }

  Future<ResultApi> removeImage({
    required BuildContext context,
    required String nameFolder,
    required int lengthImages,
  }) async {
    try {
      final storageRef = FirebaseStorage.instance.ref();
      Reference? imagesRef = storageRef.child(nameFolder);

      for (int i = 0; i < lengthImages; i++) {
        await imagesRef.child('$i.jpg').delete();
      }

      return ResultApi(isError: false, value: 'done');
    } catch (e) {
      print('from storge ${e.toString()}');
      throw context.lang.someErrorAccords;
    }
  }
}
