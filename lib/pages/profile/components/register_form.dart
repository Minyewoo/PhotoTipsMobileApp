import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_tips/constants.dart';
import 'package:photo_tips/cubit/auth_cubit.dart';
import 'package:photo_tips/pages/course/course_page.dart';
import 'package:photo_tips/widgets/custom_button.dart';
import 'package:photo_tips/widgets/form_error.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  String name;
  String email;
  String password;

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

  void submitRegistration(BuildContext context) {
    context.read<AuthCubit>().signUp(name, email, password);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        buildHeader(),
        buildNameFormField(),
        buildEmailFormField(),
        buildPasswordFormField(),
        SizedBox(height: 16),
        FormError(errors: errors),
        SizedBox(height: errors.length == 0 ? 0 : 16),
        CustomButton(
          width: 296,
          height: 48,
          borderRadius: BorderRadius.circular(4),
          tapColor: Color(
              Theme.of(context).accentColor.value - 0x000F0F0F),
          backgroundColor: Theme.of(context).accentColor,
          textColor: Color(0xFFF5F5F5),
          fontSize: Theme.of(context).textTheme.headline1.fontSize,
          title: 'Зарегистрироваться',
          onPressed: () {
            if (_formKey.currentState.validate()) {
              _formKey.currentState.save();
              if (errors.length == 0) submitRegistration(context);
              //Navigator.popAndPushNamed(context, CoursePage.routeName);
            }
          },
        ),
      ]),
    );
  }

  Container buildHeader() {
    return Container(
        height: 24,
        child: Text(
          "Зарегистрируйтесь",
          style: TextStyle(
            fontSize: 16,
            height: 1.5,
            letterSpacing: 0.15,
          ),
        ),
      );
  }

  TextFormField buildNameFormField() {
    return TextFormField(
      onSaved: (newValue) => name = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: emptyPasswordError);
        } else if (value.length >= 8) {
          removeError(error: shortPasswordError);
        }
        return;
      },
      validator: (value) {
        if (value.isEmpty) addError(error: emptyPasswordError);
        //else if (value.length < 8) addError(error: shortPasswordError);
        return;
      },
      decoration: InputDecoration(
          labelText: "Имя",
          hintText: "Введите ваше имя",
          floatingLabelBehavior: FloatingLabelBehavior.never),
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
