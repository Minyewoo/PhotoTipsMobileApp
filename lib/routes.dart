import 'package:flutter/material.dart';
import 'package:path/path.dart';

import 'package:photo_tips/pages/camera/camera_page.dart';
import 'package:photo_tips/pages/course/course_page.dart';
import 'package:photo_tips/pages/forgot_password/forgot_password_page.dart';
import 'package:photo_tips/pages/galery/galery_page.dart';
import 'package:photo_tips/pages/login/login_page.dart';
import 'package:photo_tips/pages/main/main_page.dart';
import 'package:photo_tips/pages/profile/profile_page.dart';
import 'package:photo_tips/pages/register/register_page.dart';
import 'package:photo_tips/pages/start/start_page.dart';

final Map<String, WidgetBuilder> routes = {
  MainPage.routeName: (context) => MainPage(),
  CameraPage.routeName: (context) => CameraPage(),
  CoursePage.routeName: (context) => CoursePage(),
  ProfilePage.routeName: (context) => ProfilePage(),
  GaleryPage.routeName: (context) => GaleryPage(),
  LoginPage.routeName: (context) => LoginPage(),
  RegisterPage.routeName: (context) => RegisterPage(),
  ForgorPasswordPage.routeName: (context) => ForgorPasswordPage(),
  StartPage.routeName: (context) => StartPage(),
};
