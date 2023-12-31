// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:final_project/core/components/posts/bloc/posts_cubit.dart';
import 'package:final_project/core/custom_widget/app_button.dart';
import 'package:final_project/core/custom_widget/app_text.dart';
import 'package:final_project/core/custom_widget/app_text_form_field.dart';
import 'package:final_project/core/enum/dialog_types.dart';
import 'package:final_project/core/extension/context.dart';
import 'package:final_project/core/extension/theme.dart';
import 'package:final_project/data/model/post_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'bloc/add_new_post_cubit.dart';
part 'widget/images_post.dart';
part 'widget/post_content.dart';

class AddPost extends StatelessWidget {
  const AddPost({
    super.key,
    required this.postsCubit,
    this.postEdit,
  });
  final PostsCubit postsCubit;
  final PostModel? postEdit;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddNewPostCubit>(
      create: (context) => AddNewPostCubit(
        postsCubit: postsCubit,
        postEdit: postEdit,
      ),
      child: BlocListener<AddNewPostCubit, AddNewPostState>(
        listener: (context, state) async {
          switch (state.dialogsType) {
            case DialogsType.loading:
              await showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  content: SizedBox(
                    width: 40.w,
                    height: 20.h,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: context.them.buttonColor,
                      ),
                    ),
                  ),
                ),
              ).whenComplete(
                  () => context.read<AddNewPostCubit>().restDialog());

              break;
            case DialogsType.error:
              Navigator.pop(context);
              await showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  content: SizedBox(
                    width: 40.w,
                    height: 20.h,
                    child: Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppText(text: state.errorMassage),
                        AppButton(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          title: context.lang.ok,
                        )
                      ],
                    )),
                  ),
                ),
              ).whenComplete(
                  () => context.read<AddNewPostCubit>().restDialog());
              break;
            case DialogsType.successful:
              Navigator.pop(context);
              Navigator.pop(context);
            default:
          }
        },
        listenWhen: (previous, current) =>
            previous.dialogsType != current.dialogsType,
        child: Builder(builder: (context) {
          return Scaffold(
            appBar: AppBar(
                centerTitle: true,
                title: AppText(
                  text: context.lang.addNewPost,
                )),
            body: Column(
              children: [
                const _PostContent(),
                const Expanded(child: _ImageAddPost()),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppButton(
                          onTap: () => context.read<AddNewPostCubit>().addPost(
                                context,
                              ),
                          title: context.lang.post),
                      SizedBox(
                        width: 10.w,
                      ),
                      AppButton(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        title: context.lang.cancel,
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
