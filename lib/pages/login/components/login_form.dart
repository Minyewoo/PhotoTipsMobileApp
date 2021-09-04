import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_tips/constants.dart';
import 'package:photo_tips/cubit/auth_cubit.dart';
import 'package:photo_tips/pages/course/course_page.dart';
import 'package:photo_tips/pages/forgot_password/forgot_password_page.dart';
import 'package:photo_tips/widgets/custom_button.dart';
import 'package:photo_tips/widgets/form_error.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  String email;
  String password;
  bool remember = false;
  List<String> errors = [];

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  void submitLogin(BuildContext context) {
    context.read<AuthCubit>().signIn(email, password);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        buildEmailFormField(),
        SizedBox(height: 20),
        buildPasswordFormField(),
        SizedBox(height: 20),
        Row(
          children: [
            Spacer(),
            GestureDetector(
              onTap: () =>
                  Navigator.pushNamed(context, ForgorPasswordPage.routeName),
              child: Text(
                "Забыли пароль?",
                style: TextStyle(decoration: TextDecoration.underline),
              ),
            )
          ],
        ),
        FormError(errors: errors),
        SizedBox(height: 20),
        CustomButton(
          width: 296,
          height: 48,
          borderRadius: BorderRadius.circular(4),
          tapColor: Color(
              Theme.of(context).textTheme.headline1.color.value - 0xFFA0A0A0),
          backgroundColor: Theme.of(context).textTheme.headline1.color,
          textColor: Theme.of(context).primaryColor,
          fontSize: Theme.of(context).textTheme.headline1.fontSize,
          title: 'Войти',
          onPressed: () {
            if (_formKey.currentState.validate()) {
              _formKey.currentState.save();
              if (errors.length == 0) submitLogin(context);
            }
          },
        ),
      ]),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: emptyPasswordError);
        } else if (value.length >= 8) {
          removeError(error: shortPasswordError);
        }
        return;
      },
      validator: (value) {
        if (value.isEmpty)
          addError(error: emptyPasswordError);
        else if (value.length < 8) addError(error: shortPasswordError);
        return;
      },
      obscureText: true,
      decoration: InputDecoration(
          labelText: "Пароль",
          hintText: "Введите ваш пароль",
          floatingLabelBehavior: FloatingLabelBehavior.never),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: emptyEmailError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: invalidEmailError);
        }
        return;
      },
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value.isEmpty)
          addError(error: emptyEmailError);
        else if (!emailValidatorRegExp.hasMatch(value))
          addError(error: invalidEmailError);
        return;
      },
      decoration: InputDecoration(
        labelText: "Почта",
        hintText: "Введите ваш почтовый адрес",
        floatingLabelBehavior: FloatingLabelBehavior.never,
      ),
    );
  }
}
