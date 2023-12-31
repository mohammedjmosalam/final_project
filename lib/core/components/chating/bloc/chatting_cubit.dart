import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:final_project/data/data_helper/app_data.dart';
import 'package:final_project/data/model/chat_model.dart';
import 'package:final_project/data/model/user_app.dart';
import 'package:final_project/data/repositorty/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chatting_state.dart';

class ChattingCubit extends Cubit<ChattingState> {
  final FirebaseDataBase firebaseDataBase;
  final BuildContext context;
  final UserApp userChat;
  StreamSubscription<List<ChatModel>>? streamChattingNormal;
  StreamSubscription<List<ChatModel>>? streamChattingAgents;
  Set<ChatModel> chats = {};

  ChattingCubit({
    required this.firebaseDataBase,
    required this.context,
    required this.userChat,
    this.streamChattingNormal,
    this.streamChattingAgents,
  }) : super(
          ChattingState(
            massageController: TextEditingController(),
            streamChattingController: StreamController(),
          ),
        ) {
    openStream();
  }
  openStream() {
    streamChattingAgents = firebaseDataBase
        .getMassageStream(
            fromUserId: context.read<AppData>().currentUser!.idUser,
            toUserId: userChat.idUser,
            context: context)
        .listen((event) {});

    streamChattingAgents!.onData((data) {
      chats.addAll(data);
      state.streamChattingController.add(chats.toList());
    });
    streamChattingAgents!.onError((data) {
      state.streamChattingController.addError(data);
    });

    streamChattingNormal = firebaseDataBase
        .getMassageStream(
            fromUserId: userChat.idUser,
            toUserId: context.read<AppData>().currentUser!.idUser,
            context: context)
        .listen((event) {});

    streamChattingNormal!.onData((data) {
      chats.addAll(data);
      state.streamChattingController.add(chats.toList());
    });
    streamChattingNormal!.onError((data) {
      state.streamChattingController.addError(data);
    });
  }

  @override
  Future<void> close() async {
    await streamChattingNormal?.cancel();
    await streamChattingAgents?.cancel();
    await state.streamChattingController.close();
    super.close();
  }

  Future<void> sendMassage() async {
    String massage = state.massageController.text.trim();
    if (massage.isNotEmpty) {
      DateTime now = DateTime.now();
      int idDate = now.microsecondsSinceEpoch;
      String fromUser = context.read<AppData>().currentUser!.idUser;
      ChatModel chatModel = ChatModel(
        contentMassage: massage,
        idDate: idDate,
        fromUserId: fromUser,
        toUserId: userChat.idUser,
      );
      firebaseDataBase.uploadData(
        collection: 'Chat',
        doc: idDate.toString(),
        dataUpload: chatModel.toJson,
        context: context,
      );
      state.massageController.clear();
    }
  }
}
