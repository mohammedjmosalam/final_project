// ignore_for_file: use_build_context_synchronously

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:final_project/core/extension/context.dart';
import 'package:flutter/material.dart';

import '../api/firebase_auth_api.dart';
import '../api/firebase_databse_api.dart';
import '../model/reslut_api.dart';
import '../model/user_app.dart';

class FirebaseAuthApp {
  final FirebaseAuthApi firebaseAuthApi;
  final FireBaseDatabaseApp fireBaseDatabaseApp;
  FirebaseAuthApp({
    required this.firebaseAuthApi,
    required this.fireBaseDatabaseApp,
  });
  Future<ResultApi> login({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      if (await isConnectedNetwork()) {
        var result = await firebaseAuthApi.login(
            context: context, email: email, password: password);
        String userId = result.value;
        ResultApi resultApi = await fireBaseDatabaseApp.getData(
            collection: 'Users', doc: userId, context: context);
        if (resultApi.isError) {
          return resultApi;
        } else {
          Map<String, dynamic> dataUser = resultApi.value;
          UserApp userApp = UserApp.fromJson(dataUser);
          return ResultApi(isError: false, value: userApp);
        }
      } else {
        return ResultApi(isError: true, value: context.lang.noInternetAccess);
      }
    } catch (e) {
      print(e);
      await firebaseAuthApi.signOut();
      return ResultApi(isError: true, value: e.toString());
    }
  }

  Future<ResultApi> signUp({
    required BuildContext context,
    required String birthday,
    required String email,
    required String gender,
    required String name,
    required String password,
  }) async {
    try {
      if (await isConnectedNetwork()) {
        var result = await firebaseAuthApi.signUp(
            context: context, email: email, password: password);
        String userId = result.value;

        UserApp userApp = UserApp(
            idUser: userId,
            birthday: birthday,
            email: email,
            gender: gender,
            name: name,
            password: password);
        ResultApi resultApi = await fireBaseDatabaseApp.setData(
            collection: 'Users',
            doc: userId,
            context: context,
            dataUpload: userApp.toJson());
        if (resultApi.isError) {
          return resultApi;
        } else {
          return ResultApi(isError: false, value: userApp);
        }
      } else {
        return ResultApi(isError: true, value: context.lang.noInternetAccess);
      }
    } catch (e) {
      print(e);
      await firebaseAuthApi.signOut();
      return ResultApi(isError: true, value: e.toString());
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
