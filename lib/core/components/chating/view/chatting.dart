import 'package:final_project/core/components/chating/bloc/chatting_cubit.dart';
import 'package:final_project/core/custom_widget/app_button.dart';
import 'package:final_project/core/custom_widget/app_icon.dart';
import 'package:final_project/core/custom_widget/app_text.dart';
import 'package:final_project/core/custom_widget/app_text_form_field.dart';
import 'package:final_project/core/extension/context.dart';
import 'package:final_project/core/extension/theme.dart';
import 'package:final_project/data/api/firebase_databse_api.dart';
import 'package:final_project/data/data_helper/app_data.dart';
import 'package:final_project/data/model/chat_model.dart';
import 'package:final_project/data/model/user_app.dart';
import 'package:final_project/data/repositorty/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
part 'widget/write_massage.dart';
part 'widget/chatting_massage.dart';
part 'widget/single_chat.dart';

class Chatting extends StatelessWidget {
  const Chatting({
    super.key,
    required this.toUser,
  });
  final UserApp toUser;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChattingCubit>(
      create: (contextB) => ChattingCubit(
        context: context,
        firebaseDataBase: FirebaseDataBase(
          FireBaseDatabaseApp(),
        ),
        userChat: toUser,
      ),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: context.them.buttonColor,
          automaticallyImplyLeading: false,
          title: AppText(
            text: toUser.name,
            textColor: Colors.white,
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const AppIcon(
              icon: Icons.arrow_back,
              iconColor: Colors.white,
            ),
          ),
        ),
        backgroundColor: context.them.backgroundAppColor,
        body: const Column(
          children: [
            Expanded(child: _ChattingMassage()),
            _WriteMassage(),
          ],
        ),
      ),
    );
  }
}
