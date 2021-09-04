import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:photo_tips/camera_config.dart';
import 'package:photo_tips/cubit/auth_cubit.dart';
import 'package:photo_tips/cubit/module_cubit.dart';
import 'package:photo_tips/cubit/photo_cubit.dart';
import 'package:photo_tips/cubit/submission_cubit.dart';
import 'package:photo_tips/cubit/user_cubit.dart';
import 'package:photo_tips/data/repositories/module_repository.dart';
import 'package:photo_tips/data/repositories/submission_repository.dart';
import 'package:photo_tips/data/repositories/user_repository.dart';
import 'package:photo_tips/pages/course/course_page.dart';
import 'package:photo_tips/pages/main/main_page.dart';
import 'package:photo_tips/pages/start/start_page.dart';
import 'package:photo_tips/routes.dart';
import 'package:photo_tips/themes.dart';
import 'data/repositories/auth_repository.dart';
import 'data/repositories/photo_repository.dart';

Future<void> main() async {
  if (Platform.isAndroid)
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      //systemNavigationBarColor: Colors.transparent,
      statusBarColor: Colors.transparent,
    ));

  WidgetsFlutterBinding.ensureInitialized();

  HydratedBloc.storage = await HydratedStorage.build();

  CameraConfig().init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserCubit>(
          create: (context) => UserCubit(
            ApiUserRepository(),
          ),
        ),
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(
            ApiAuthRepository(),
            context.read<UserCubit>(),
          ),
        ),
        BlocProvider<ModuleCubit>(
          create: (context) => ModuleCubit(
            ApiModuleRepository(),
          ),
        ),
        BlocProvider<PhotoCubit>(
          create: (context) => PhotoCubit(
            ApiPhotoRepository(),
          ),
        ),
        BlocProvider<SubmissionCubit>(
          create: (context) => SubmissionCubit(
            ApiSubmissionRepository(),
            context.read<AuthCubit>()
          ),
        ),
      ],
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          String initialRoute;
          if (state is AuthSignedIn) {
            initialRoute = MainPage.routeName;
          } else {
            initialRoute = StartPage.routeName;
          }
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'PhotoTips',
            darkTheme: darkTheme,
            theme: lightTheme,
            routes: routes,
            initialRoute: initialRoute,
          );
        },
      ),
    );
  }
}
