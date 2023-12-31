// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/core/extension/context.dart';
import 'package:final_project/data/model/chat_model.dart';
import 'package:final_project/data/model/post_model.dart';
import 'package:final_project/data/model/reslut_api.dart';
import 'package:final_project/data/model/user_app.dart';
import 'package:flutter/material.dart';

class FireBaseDatabaseApp {
  Future<ResultApi> getData({
    required String collection,
    required doc,
    required BuildContext context,
  }) async {
    try {
      var data = FirebaseFirestore.instance.collection(collection).doc(doc);
      var dataResult = await data.get();
      if (dataResult.exists) {
        return ResultApi(isError: false, value: dataResult.data());
      } else {
        return ResultApi(isError: true, value: context.lang.noDataExist);
      }
    } catch (e) {
      print('error in get data ${e.toString()}');
      throw context.lang.someErrorAccords;
    }
  }

  Future<ResultApi> removeDoc({
    required String collection,
    required doc,
    required BuildContext context,
  }) async {
    try {
      var data = FirebaseFirestore.instance.collection(collection).doc(doc);
      await data.delete();
      return ResultApi(isError: false, value: 'done');
    } catch (e) {
      print('error in get data ${e.toString()}');
      throw context.lang.someErrorAccords;
    }
  }

  Future<ResultApi> getDataFromList({
    required String collection,
    required List<String> listData,
    required BuildContext context,
  }) async {
    try {
      var data = FirebaseFirestore.instance.collection(collection);
      var whereData = data.where('idUser', whereIn: listData);
      var dataResult = await whereData.get();
      List<UserApp> users = [];
      for (var element in dataResult.docs) {
        users.add(UserApp.fromJson(element.data()));
      }
      return ResultApi(isError: false, value: users);
    } catch (e) {
      print('error in get data ${e.toString()}');
      throw context.lang.someErrorAccords;
    }
  }

  Future<ResultApi> getMultiData({
    required String collection,
    required BuildContext context,
    String? userId,
  }) async {
    try {
      print(collection);
      var data =
          FirebaseFirestore.instance.collection(collection).where('idPost');
      if (userId != null) {
        data = data.where('idUserPost', isEqualTo: userId);
      }
      var dataSorted = data.orderBy('idPost', descending: true);
      var dataResult = await dataSorted.get();
      List<PostModel> posts = [];
      for (var element in dataResult.docs) {
        if (element.exists) {
          posts.add(PostModel.fromJson(element.data()));
        }
      }
      return ResultApi(isError: false, value: posts);
    } catch (e) {
      print('error in set data ${e.toString()}');
      throw context.lang.someErrorAccords;
    }
  }

  Future<ResultApi> setData({
    required String collection,
    required doc,
    required BuildContext context,
    required Map<String, dynamic> dataUpload,
  }) async {
    try {
      var data = FirebaseFirestore.instance.collection(collection).doc(doc);
      await data.set(dataUpload);
      return ResultApi(isError: false, value: '');
    } catch (e) {
      print('error in set data ${e.toString()}');
      throw context.lang.someErrorAccords;
    }
  }

  Stream<List<ChatModel>> getMassageStream({
    required String fromUserId,
    required String toUserId,
    required BuildContext context,
  }) async* {
    try {
      var data = FirebaseFirestore.instance.collection('Chat');
      var dataFlitter = data.where(
        'fromUserId',
        isEqualTo: fromUserId,
      );
      dataFlitter = dataFlitter.where('toUserId', isEqualTo: toUserId);
      // dataFlitter = dataFlitter.where('users', arrayContains: fromUserId);
      yield* dataFlitter.snapshots().transform(StreamTransformer.fromHandlers(
            handleData: (data, sink) => sink.add(
              List.generate(
                data.docs.length,
                (index) => ChatModel.fromJson(
                  data.docs.elementAt(index).data(),
                ),
              ),
            ),
          ));
    } catch (e) {
      print(e.toString());
      throw context.lang.someErrorAccords;
    }
  }
}
