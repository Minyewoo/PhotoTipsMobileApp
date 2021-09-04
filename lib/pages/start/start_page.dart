import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:photo_tips/pages/course/course_page.dart';
import 'package:photo_tips/pages/login/login_page.dart';
import 'package:photo_tips/pages/main/main_page.dart';
import 'package:photo_tips/pages/register/register_page.dart';
import 'package:photo_tips/widgets/custom_button.dart';

class StartPage extends StatelessWidget {
  static String routeName = '/start';
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SvgPicture.asset(
                theme.appBarTheme.brightness == Brightness.light
                    ? "assets/icons/logo.svg"
                    : "assets/icons/logo_dark.svg",
                width: 156,
                height: 27.46,
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomButton(
                          width: 296,
                          height: 48,
                          borderRadius: BorderRadius.circular(4),
                          tapColor: Color(
                              theme.textTheme.headline1.color.value -
                                  0xFFA0A0A0),
                          backgroundColor: theme.textTheme.headline1.color,
                          textColor: theme.primaryColor,
                          fontSize: theme.textTheme.headline1.fontSize,
                          title: "Зарегистрироваться",
                          onPressed: () => Navigator.pushNamed(
                              context, RegisterPage.routeName),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        CustomButton(
                          width: 296,
                          height: 48,
                          tapColor: theme.primaryColor,
                          backgroundColor: theme.primaryColor,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                              color: theme.textTheme.headline1.color),
                          title: "Войти",
                          textColor: theme.textTheme.headline1.color,
                          fontSize: theme.textTheme.headline1.fontSize,
                          onPressed: () =>
                              Navigator.pushNamed(context, LoginPage.routeName),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: InkWell(
              onTap: () =>
                  Navigator.popAndPushNamed(context, MainPage.routeName),
              child: Container(
                height: 40,
                width: 73,
                color: Colors.transparent,
                child: Center(
                  child: Text(
                    'Пропустить',
                    style: TextStyle(
                      color: theme.accentColor,
                      fontSize: theme.textTheme.bodyText1.fontSize,
                      height: theme.textTheme.bodyText1.height,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
