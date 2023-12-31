import 'package:final_project/config/route/app_route.dart';
import 'package:final_project/core/components/chating/view/chatting.dart';
import 'package:final_project/core/components/posts/bloc/posts_cubit.dart';
import 'package:final_project/data/model/post_model.dart';
import 'package:final_project/feature/profile/view/profile.dart';
import 'package:flutter/material.dart';

import '../../core/components/add_post/add_post.dart';
import '../../feature/home/home.dart';
import '../../feature/registration/restration.dart';
import '../../feature/splash_screen/splash_screen.dart';

class OnGenerate {
  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoute.splashScreen:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
      case AppRoute.registration:
        return MaterialPageRoute(
          builder: (context) => const Registration(),
        );
      case AppRoute.home:
        return MaterialPageRoute(
          builder: (context) => Home(),
        );
      case AppRoute.addPost:
        return MaterialPageRoute(
          builder: (context) => AddPost(
            postsCubit: (settings.arguments as List).first as PostsCubit,
            postEdit: ((settings.arguments as List).length > 1
                ? (settings.arguments as List).lastOrNull
                : null) as PostModel?,
          ),
        );
      case AppRoute.profile:
        return MaterialPageRoute(
          builder: (context) => Profile(
            userData: (settings.arguments as List).first,
          ),
        );
      case AppRoute.chatting:
        return MaterialPageRoute(
          builder: (context) => Chatting(
            toUser: (settings.arguments as List).first,
          ),
        );

      default:
    }
    return null;
  }
}
