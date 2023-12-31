// ignore_for_file: use_build_context_synchronously

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:final_project/core/extension/context.dart';
import 'package:final_project/data/model/chat_model.dart';
import 'package:flutter/material.dart';

import '../api/firebase_databse_api.dart';
import '../model/reslut_api.dart';

class FirebaseDataBase {
  final FireBaseDatabaseApp fireBaseDatabaseApp;
  FirebaseDataBase(this.fireBaseDatabaseApp);
  Future<ResultApi> getData({
    required String collection,
    required String doc,
    required BuildContext context,
  }) async {
    if (await isConnectedNetwork()) {
      try {
        final ResultApi resultApi = await fireBaseDatabaseApp.getData(
            collection: collection, doc: doc, context: context);
        return resultApi;
      } catch (e) {
        return ResultApi(isError: true, value: e.toString());
      }
    } else {
      return ResultApi(isError: true, value: context.lang.noInternetAccess);
    }
  }

  Future<ResultApi> removeDoc({
    required String collection,
    required String doc,
    required BuildContext context,
  }) async {
    if (await isConnectedNetwork()) {
      try {
        final ResultApi resultApi = await fireBaseDatabaseApp.removeDoc(
            collection: collection, doc: doc, context: context);
        return resultApi;
      } catch (e) {
        return ResultApi(isError: true, value: e.toString());
      }
    } else {
      return ResultApi(isError: true, value: context.lang.noInternetAccess);
    }
  }

  Future<ResultApi> getDataFromList({
    required String collection,
    required List<String> listData,
    required BuildContext context,
  }) async {
    if (await isConnectedNetwork()) {
      try {
        final ResultApi resultApi = await fireBaseDatabaseApp.getDataFromList(
            collection: collection, listData: listData, context: context);
        return resultApi;
      } catch (e) {
        return ResultApi(isError: true, value: e.toString());
      }
    } else {
      return ResultApi(isError: true, value: context.lang.noInternetAccess);
    }
  }

  Future<ResultApi> getMultiData({
    required String collection,
    required BuildContext context,
    String? userId,
  }) async {
    if (await isConnectedNetwork()) {
      try {
        final ResultApi resultApi = await fireBaseDatabaseApp.getMultiData(
            collection: collection, userId: userId, context: context);
        return resultApi;
      } catch (e) {
        return ResultApi(isError: true, value: e.toString());
      }
    } else {
      return ResultApi(isError: true, value: context.lang.noInternetAccess);
    }
  }

  Future<ResultApi> uploadData({
    required String collection,
    required doc,
    required Map<String, dynamic> dataUpload,
    required BuildContext context,
  }) async {
    if (await isConnectedNetwork()) {
      try {
        final ResultApi resultApi = await fireBaseDatabaseApp.setData(
          collection: collection,
          doc: doc,
          context: context,
          dataUpload: dataUpload,
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

  Stream<List<ChatModel>> getMassageStream({
    required String fromUserId,
    required String toUserId,
    required BuildContext context,
  }) async* {
    if (await isConnectedNetwork()) {
      try {
        yield* fireBaseDatabaseApp.getMassageStream(
          context: context,
          fromUserId: fromUserId,
          toUserId: toUserId,
        );
      } catch (e) {
        throw e.toString();
      }
    } else {
      throw context.lang.noInternetAccess;
    }
  }
}
