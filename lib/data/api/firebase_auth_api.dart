import 'package:final_project/core/extension/context.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../model/reslut_api.dart';

class FirebaseAuthApi {
  Future<ResultApi> login({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return ResultApi(isError: false, value: credential.user!.uid);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' ||
          e.code.trim() == 'INVALID_LOGIN_CREDENTIALS') {
        throw context.lang.errorEmailFirebase;
      } else if (e.code == 'wrong-password') {
        throw context.lang.errorPasswordFirebase;
      } else {
        throw context.lang.someErrorAccords;
      }
    }
  }

  Future<ResultApi> signUp({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return ResultApi(isError: false, value: credential.user!.uid);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw context.lang.errorPasswordFirebase;
      } else if (e.code == 'email-already-in-use') {
        throw context.lang.emailIsExist;
      } else {
        throw context.lang.someErrorAccords;
      }
    }
  }

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
