import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:final_project/config/controller_app/app_controller_cubit.dart';
import 'package:final_project/config/route/app_route.dart';
import 'package:final_project/core/custom_widget/app_text.dart';
import 'package:final_project/core/extension/context.dart';
import 'package:final_project/core/extension/theme.dart';
import 'package:final_project/data/data_helper/app_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:slide_switcher/slide_switcher.dart';

import '../../core/components/posts/post_view_and_show_posts.dart';
part 'widget/drawer.dart';

class Home extends StatelessWidget {
  Home({super.key});
  final GlobalKey<ScaffoldState> keyScaffold = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Scaffold(
        key: keyScaffold,
        backgroundColor: context.them.backgroundAppColor,
        drawer: Drawer(
          backgroundColor: context.them.backgroundAppColor,
          child: const _DrawerHome(),
        ),
        appBar: PreferredSize(
          preferredSize: Size(MediaQuery.sizeOf(context).width, 50.h),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  context.them.buttonColor,
                  Colors.pink.shade200,
                  context.them.backgroundAppColor,
                ],
              ),
            ),
            child: Row(
              textDirection: TextDirection.ltr,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3.h),
                  child: AppText(
                    text: 'Facebook and Insta',
                    fontSize: 17.sp,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    keyScaffold.currentState!.openDrawer();
                  },
                  icon: Icon(
                    Icons.menu,
                    size: 3.h,
                  ),
                )
              ],
            ),
          ),
        ),
        body: AddPostAndPostsView(keyScaffold: keyScaffold),
      ),
    );
  }
}
