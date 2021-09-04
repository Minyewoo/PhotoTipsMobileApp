import 'package:flutter/material.dart';
import 'forgot_password_form.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              //SizedBox(height: ScreenConfig.screenHeight * 0.08),
              Text(
                'Пожалуйста, введите вашу почту и \nмы отправим Вам ссылку \nна восстановление аккаунта',
                textAlign: TextAlign.center,
              ),
              //SizedBox(height: ScreenConfig.screenHeight * 0.04),
              ForgotPasswordForm(),
            ],
          ),
        ),
      ),
    );
  }
}