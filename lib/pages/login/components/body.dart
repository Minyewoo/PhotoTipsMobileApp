import 'package:flutter/material.dart';
import 'login_form.dart';
import 'no_account_text.dart';
import 'social_sircle.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              //SizedBox(height: ScreenConfig.screenHeight * 0.2),
              LoginForm(),
              //SizedBox(height: ScreenConfig.screenHeight * 0.08),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  
                  // SocialCircle(
                  //   iconPath: "assets/icons/vk_logo.svg",
                  //   pressAction: () {},
                  // ),
                  // SocialCircle(
                  //   iconPath: "assets/icons/facebook_logo.svg",
                  //   pressAction: () {},
                  // ),
                ],
              ),
              SizedBox(height: 20),
              NoAccountText()
            ],
          ),
        ),
      ),
    );
  }
}