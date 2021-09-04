import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_tips/cubit/auth_cubit.dart';
import 'package:photo_tips/cubit/user_cubit.dart';
import 'package:photo_tips/data/models/user.dart';
import 'package:photo_tips/pages/course/course_page.dart';
import 'package:photo_tips/pages/galery/galery_page.dart';
import 'package:photo_tips/pages/login/login_page.dart';
import 'package:photo_tips/pages/profile/components/change_user_form.dart';
import 'package:photo_tips/pages/profile/components/register_form.dart';
import 'package:photo_tips/pages/profile/settings_page.dart';
import 'package:photo_tips/widgets/custom_button.dart';

class ProfilePage extends StatefulWidget {
  static String routeName = "/profile";

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<String> routeNames = [
    CoursePage.routeName,
    ProfilePage.routeName,
    GaleryPage.routeName,
  ];
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    if (index != _selectedIndex)
      Navigator.pushNamed(context, routeNames[index]);
  }

  void showErrorAndRetry(BuildContext context, String message) {
    Timer(Duration(seconds: 5), () => submitToken(context));
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text('${message}. Повтор через 5 секунд'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if (state is UserError) {
          showErrorAndRetry(context, state.message);
        }
      },
      builder: (context, state) {
        final authState = context.watch<AuthCubit>().state;
        if (state is UserInitial) {
          if (authState is AuthInitial) {
            return buildInitialProfilePage(context);
          } else {
            submitToken(context);
            return buildLoadingProfilePage(context);
          }
        } else if (state is UserLoading) {
          return buildLoadingProfilePage(context);
        } else if (state is UserLoaded) {
          return buildProfilePageWithData(context, state);
        } else {
          return buildInitialProfilePage(context);
        }
      },
    );
  }

  Scaffold buildProfilePageWithData(BuildContext context, UserLoaded state) {
    return Scaffold(
      appBar: buildAppBarWithData(state.user),
      body: buildBodyWithData(context, state.user),
      //bottomNavigationBar: buildBottomNavigationBar(context),
    );
  }

  Scaffold buildLoadingProfilePage(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
      //bottomNavigationBar: buildBottomNavigationBar(context),
    );
  }

  Scaffold buildInitialProfilePage(BuildContext context) {
    return Scaffold(
      appBar: buildInitialAppBar(),
      body: buildInitialBody(
          context), /*Center(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                'Войдите или зарегистрируйтесь, чтобы получить информацию о профиле'),
            RaisedButton(
              onPressed: () =>
                  Navigator.pushNamed(context, LoginPage.routeName),
              child: Text('Войти'),
            ),
            RaisedButton(
              onPressed: () =>
                  Navigator.pushNamed(context, LoginPage.routeName),
              child: Text('Зарегистрироваться'),
            ),
          ],
        ),
      ))*/
      //bottomNavigationBar: buildBottomNavigationBar(context),
    );
  }

  ClipRRect buildBottomNavigationBar(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
            border: Border(
                top: BorderSide(
              color: Color(0xFFDDDDDD),
              width: 1,
            )),
          ),
          child: BottomNavigationBar(
            elevation: 0,
            items: [
              BottomNavigationBarItem(
                label: "Курс",
                icon: Icon(Icons.import_contacts),
                backgroundColor: Colors.transparent,
              ),
              BottomNavigationBarItem(
                label: "Профиль",
                icon: Icon(Icons.person),
                backgroundColor: Colors.transparent,
              ),
              BottomNavigationBarItem(
                label: "Галерея",
                icon: Icon(Icons.photo_library),
                backgroundColor: Colors.transparent,
              ),
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }

  SingleChildScrollView buildBodyWithData(BuildContext context, User user) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Color(0xFFDDDDDD))),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: ChangeUserForm(name: user?.name, email: user?.email, phoneNumber: user?.phoneNumber,),
                // child: Form(
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Container(
                //         height: 24,
                //         child: Text(
                //           "Персональная информация",
                //           style: TextStyle(
                //             fontSize: 16,
                //             height: 1.5,
                //             letterSpacing: 0.15,
                //           ),
                //         ),
                //       ),
                //       TextFormField(
                //         controller:
                //             TextEditingController(text: '${user?.name ?? ""}'),
                //         decoration: InputDecoration(
                //           labelText: 'Имя',
                //           labelStyle: TextStyle(
                //             color: Theme.of(context).textTheme.headline4.color,
                //             height:
                //                 Theme.of(context).textTheme.headline4.height,
                //             fontSize:
                //                 Theme.of(context).textTheme.headline4.fontSize,
                //           ),
                //         ),
                //       ),
                //       TextFormField(
                //         controller: TextEditingController(
                //             text: '${user?.surname ?? ""}'),
                //         decoration: InputDecoration(
                //           labelText: 'Фамилия',
                //           labelStyle: TextStyle(
                //             color: Theme.of(context).textTheme.headline4.color,
                //             height:
                //                 Theme.of(context).textTheme.headline4.height,
                //             fontSize:
                //                 Theme.of(context).textTheme.headline4.fontSize,
                //           ),
                //         ),
                //       ),
                //       TextFormField(
                //         controller: TextEditingController(
                //             text: '${user?.phoneNumber ?? ""}'),
                //         decoration: InputDecoration(
                //           labelText: 'Номер телефона',
                //           labelStyle: TextStyle(
                //             color: Theme.of(context).textTheme.headline4.color,
                //             height:
                //                 Theme.of(context).textTheme.headline4.height,
                //             fontSize:
                //                 Theme.of(context).textTheme.headline4.fontSize,
                //           ),
                //         ),
                //       ),
                //       TextFormField(
                //         controller: TextEditingController(
                //             text: '${user?.residenceCity?.name ?? ""}'),
                //         decoration: InputDecoration(
                //           labelText: 'Город',
                //           labelStyle: TextStyle(
                //             color: Theme.of(context).textTheme.headline4.color,
                //             height:
                //                 Theme.of(context).textTheme.headline4.height,
                //             fontSize:
                //                 Theme.of(context).textTheme.headline4.fontSize,
                //           ),
                //         ),
                //       ),
                //       /*Padding(
                //         padding: EdgeInsets.only(top: 32),
                //         child: Text(
                //           "Изменение пароля",
                //           style: TextStyle(
                //             fontSize: 16,
                //             height: 1.5,
                //             letterSpacing: 0.15,
                //           ),
                //         ),
                //       ),
                //       TextFormField(
                //         decoration: InputDecoration(
                //           labelText: "Текущий пароль",
                //           labelStyle: TextStyle(
                //             color: Theme.of(context).textTheme.headline4.color,
                //             height: Theme.of(context).textTheme.headline4.height,
                //             fontSize:
                //                 Theme.of(context).textTheme.headline4.fontSize,
                //           ),
                //           floatingLabelBehavior: FloatingLabelBehavior.auto,
                //           suffixIcon: IconButton(
                //               icon: Icon(
                //                 Icons.visibility_off,
                //                 color: Theme.of(context).textTheme.headline1.color,
                //               ),
                //               onPressed: () {}),
                //         ),
                //       ),
                //       TextFormField(
                //         decoration: InputDecoration(
                //           labelText: "Новый пароль",
                //           labelStyle: TextStyle(
                //             color: Theme.of(context).textTheme.headline4.color,
                //             height: Theme.of(context).textTheme.headline4.height,
                //             fontSize:
                //                 Theme.of(context).textTheme.headline4.fontSize,
                //           ),
                //           floatingLabelBehavior: FloatingLabelBehavior.auto,
                //           suffixIcon: IconButton(
                //               icon: Icon(
                //                 Icons.visibility_off,
                //                 color: Theme.of(context).textTheme.headline1.color,
                //               ),
                //               onPressed: () {}),
                //         ),
                //       ),
                //       TextFormField(
                //         decoration: InputDecoration(
                //           labelText: "Повторите новый пароль",
                //           labelStyle: TextStyle(
                //             color: Theme.of(context).textTheme.headline4.color,
                //             height: Theme.of(context).textTheme.headline4.height,
                //             fontSize:
                //                 Theme.of(context).textTheme.headline4.fontSize,
                //           ),
                //           floatingLabelBehavior: FloatingLabelBehavior.auto,
                //           suffixIcon: IconButton(
                //               icon: Icon(
                //                 Icons.visibility_off,
                //                 color: Theme.of(context).textTheme.headline1.color,
                //               ),
                //               onPressed: () {}),
                //         ),
                //       ),
                //       Padding(
                //         padding: EdgeInsets.only(
                //           top: 40,
                //         ),
                //         child: Center(
                //           child: CustomButton(
                //             width: 328,
                //             height: 48,
                //             borderRadius: BorderRadius.circular(4),
                //             tapColor: Color(
                //                 Theme.of(context).textTheme.headline1.color.value -
                //                     0xFFA0A0A0),
                //             backgroundColor:
                //                 Theme.of(context).textTheme.headline1.color,
                //             textColor: Theme.of(context).primaryColor,
                //             fontSize:
                //                 Theme.of(context).textTheme.headline1.fontSize,
                //             title: "Изменить",
                //             onPressed: () =>
                //                 Navigator.pushNamed(context, CoursePage.routeName),
                //           ),
                //         ),
                //       ),*/
                //     ],
                //   ),
                // ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 16,
            ),
            child: Center(
              child: CustomButton(
                width: 328,
                height: 48,
                borderRadius: BorderRadius.circular(4),
                tapColor: Color(
                    Theme.of(context).textTheme.headline1.color.value -
                        0xFFA0A0A0),
                backgroundColor: Theme.of(context).accentColor,
                textColor: Theme.of(context).primaryColor,
                fontSize: Theme.of(context).textTheme.headline1.fontSize,
                title: "Выйти из аккаунта",
                onPressed: () => logOut(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  PreferredSize buildAppBarWithData(User user) {
    return PreferredSize(
      preferredSize: Size.fromHeight(56),
      child: AppBar(
        elevation: 0,
        bottom: PreferredSize(
            child: Container(
              height: 1,
              color: Color(0xFFDDDDDD),
            ),
            preferredSize: Size.fromHeight(1)),
        automaticallyImplyLeading: false,
        flexibleSpace: SafeArea(
          child: Container(
            height: 56,
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
              child: Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFCDCDCD),
                    ),
                    child: Icon(
                      Icons.camera_alt,
                      color: Color(0xFF878787),
                      size: 16,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${user?.name ?? "Безымянный"} ${user?.surname ?? ""}',
                          style: TextStyle(
                            color: Theme.of(context).textTheme.headline1.color,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            height: 24.0 / 16.0,
                            letterSpacing: 0.15,
                          ),
                        ),
                        Text(
                          '${user?.email}',
                          style: TextStyle(
                            color: Theme.of(context).textTheme.headline1.color,
                            fontSize: 12,
                            height: 16.0 / 12.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  ClipOval(
                    child: Material(
                      color: Colors.transparent,
                      child: Container(
                        width: 56,
                        height: 56,
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute<void>(
                                builder: (BuildContext context) {
                              return SettingsPage();
                            }));
                          },
                          child: Container(
                            width: 56,
                            height: 56,
                            child: Icon(
                              Icons.settings,
                              color:
                                  Theme.of(context).textTheme.headline1.color,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  /*ClipOval(
                    child: Material(
                      color: Colors.transparent,
                      child: Container(
                        width: 56,
                        height: 56,
                        child: InkWell(
                          onTap: () => logOut(context),
                          child: Container(
                            width: 56,
                            height: 56,
                            child: Icon(
                              Icons.logout,
                              color:
                                  Theme.of(context).textTheme.headline1.color,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),*/
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  SingleChildScrollView buildInitialBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Color(0xFFDDDDDD))),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: RegisterForm(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Center(
              child: Text(
                'Уже есть аккаунт?',
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 32,
            ),
            child: Center(
              child: CustomButton(
                border: Border.all(color: Color(0xFFDDDDDD)),
                width: 296,
                height: 48,
                borderRadius: BorderRadius.circular(4),
                tapColor: Color(0xFFDDDDDD),
                backgroundColor: Theme.of(context).primaryColor,
                textColor: Theme.of(context).textTheme.headline1.color,
                fontSize: Theme.of(context).textTheme.headline1.fontSize,
                title: "Войти",
                onPressed: () =>
                    Navigator.pushNamed(context, LoginPage.routeName),
              ),
            ),
          ),
        ],
      ),
    );
  }

  PreferredSize buildInitialAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(56),
      child: AppBar(
        elevation: 0,
        bottom: PreferredSize(
            child: Container(
              height: 1,
              color: Color(0xFFDDDDDD),
            ),
            preferredSize: Size.fromHeight(1)),
        automaticallyImplyLeading: false,
        flexibleSpace: SafeArea(
          child: Container(
            height: 56,
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
              child: Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFCDCDCD),
                    ),
                    child: Icon(
                      Icons.camera_alt,
                      color: Color(0xFF878787),
                      size: 16,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Неопознанный пришелец',
                          style: TextStyle(
                            color: Theme.of(context).textTheme.headline1.color,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            height: 24.0 / 16.0,
                            letterSpacing: 0.15,
                          ),
                        ),
                        Text(
                          'unidentified@gmail.com',
                          style: TextStyle(
                            color: Theme.of(context).textTheme.headline1.color,
                            fontSize: 12,
                            height: 16.0 / 12.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void submitToken(BuildContext context) {
    final authCubitState = context.watch<AuthCubit>().state;
    final userCubit = context.watch<UserCubit>();
    if (authCubitState is AuthSignedIn) {
      final token = authCubitState.token;
      userCubit.getUser(token);
    }
  }

  void logOut(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    authCubit.logOut();
  }
}
