import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'config/controller_app/app_controller_cubit.dart';
import 'config/firebase/firebase_options.dart';
import 'config/route/on_generate.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'data/data_helper/app_data.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AppData>(
          create: (context) => AppData(),
        ),
      ],
      child: ResponsiveSizer(
        builder: (context, orientation, screenType) {
          return BlocProvider<AppControllerCubit>(
            create: (context) => AppControllerCubit(),
            child: BlocBuilder<AppControllerCubit, AppControllerState>(
              builder: (context, state) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Flutter Demo',
                  locale: state.appLang,
                  supportedLocales: AppLocalizations.supportedLocales,
                  localizationsDelegates:
                      AppLocalizations.localizationsDelegates,
                  theme: ThemeData(
                    useMaterial3: true,
                    brightness: state.appTheme,
                  ),
                  onGenerateRoute: OnGenerate().onGenerateRoute,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
