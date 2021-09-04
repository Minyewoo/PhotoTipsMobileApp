import 'package:flutter/material.dart';
import 'package:photo_tips/constants.dart';
import 'package:photo_tips/pages/login/components/no_account_text.dart';
import 'package:photo_tips/widgets/custom_button.dart';
import 'package:photo_tips/widgets/form_error.dart';

class ForgotPasswordForm extends StatefulWidget {
  @override
  _ForgotPasswordFormState createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  List<String> errors = [];
  String email;

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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildForgotPassworEmailField(),
          SizedBox(height: 30),
          FormError(errors: errors),
          //SizedBox(height: ScreenConfig.screenHeight * 0.08),
          CustomButton(
            width: 296,
            height: 48,
            borderRadius: BorderRadius.circular(4),
            tapColor: Color(
                Theme.of(context).textTheme.headline1.color.value - 0xFFA0A0A0),
            backgroundColor: Theme.of(context).textTheme.headline1.color,
            textColor: Theme.of(context).primaryColor,
            fontSize: Theme.of(context).textTheme.headline1.fontSize,
            title: 'Продолжить',
            onPressed: () {
              if (_formKey.currentState.validate()) {
                //le pook
              }
            },
          ),

          //SizedBox(height: ScreenConfig.screenHeight * 0.08),
          NoAccountText(),
        ],
      ),
    );
  }

  TextFormField buildForgotPassworEmailField() {
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
          floatingLabelBehavior: FloatingLabelBehavior.never),
    );
  }
}
