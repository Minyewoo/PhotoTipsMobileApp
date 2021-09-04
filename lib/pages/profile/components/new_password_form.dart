import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_tips/constants.dart';
import 'package:photo_tips/cubit/auth_cubit.dart';
import 'package:photo_tips/cubit/user_cubit.dart';
import 'package:photo_tips/pages/course/course_page.dart';
import 'package:photo_tips/widgets/custom_button.dart';
import 'package:photo_tips/widgets/form_error.dart';
import 'package:photo_tips/data/repositories/user_repository.dart';

class NewPasswordForm extends StatefulWidget {
  @override
  _NewPasswordFormState createState() => _NewPasswordFormState();
}

class _NewPasswordFormState extends State<NewPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  String oldPassword;
  String newPassword;
  String newPasswordRepeated;
  TextEditingController oldPassController = TextEditingController();
  TextEditingController newPassController = TextEditingController();
  TextEditingController newPassRepeatedController = TextEditingController();
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

  Future<void> changePassword(BuildContext context) async {
    var state = context.read<AuthCubit>().state;
    if (state is AuthSignedIn) {
      try {
        var token = await ApiUserRepository()
            .changePassword(state.token, oldPassword, newPassword);
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text("Пароль изменён"),
        ));
        context.read<UserCubit>().getUser(token);
      } catch (e) {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text("Что-то пошло не так"),
        ));
      }
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Что-то пошло не так"),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          height: 24,
          child: Text(
            "Изменение пароля",
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
        buildOldPasswordFormField(context),
        buildNewPasswordFormField(context),
        buildNewPasswordRepeatedFormField(context),
        SizedBox(height: 16),
        FormError(errors: errors),
        SizedBox(height: errors.length == 0 ? 0 : 16),
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: CustomButton(
            width: 328,
            height: 48,
            borderRadius: BorderRadius.circular(4),
            tapColor: Color(
                Theme.of(context).textTheme.headline1.color.value - 0xFFA0A0A0),
            backgroundColor: Theme.of(context).accentColor,
            textColor: Theme.of(context).primaryColor,
            fontSize: Theme.of(context).textTheme.headline1.fontSize,
            title: "Изменить",
            onPressed: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                if (errors.length == 0) changePassword(context);
              }
            },
          ),
        ),
      ]),
    );
  }

  void setOld(String oldPass) {
    setState(() {
      oldPassword = oldPass;
    });
  }

  void setNew(String newPass) {
    setState(() {
      newPassword = newPass;
    });
  }

  void setNewRepeated(String newPassRepeated) {
    setState(() {
      newPasswordRepeated = newPassRepeated;
    });
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

  TextFormField buildOldPasswordFormField(BuildContext context) {
    return TextFormField(
      controller: oldPassController,
      onSaved: (newValue) => oldPassword = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          //setOld(value);
          //_formKey.currentState.save();
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
          labelStyle: Theme.of(context)
              .textTheme
              .headline3
              .copyWith(color: Theme.of(context).textTheme.headline4.color),
          labelText: "Текущий пароль",
          hintText: "Введите ваш текущий пароль",
          floatingLabelBehavior: FloatingLabelBehavior.never),
    );
  }

  TextFormField buildNewPasswordFormField(BuildContext context) {
    return TextFormField(
      controller: newPassController,
      onSaved: (newValue) => newPassword = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          //setNew(newPassword);
          removeError(error: emptyPasswordError);
        } else if (value.length >= 8) {
          removeError(error: shortPasswordError);
        } else if (value != oldPassController.text)
          removeError(error: matchOldNewPasswordError);

        

        
        return;
      },
      validator: (value) {
        if (value.isEmpty)
        {
          addError(error: emptyPasswordError);
        }
        else if (value.length < 8)
          addError(error: shortPasswordError);
        else if (value == oldPassController.text)
          addError(error: matchOldNewPasswordError);
        return;
      },
      obscureText: true,
      decoration: InputDecoration(
          labelStyle: Theme.of(context)
              .textTheme
              .headline3
              .copyWith(color: Theme.of(context).textTheme.headline4.color),
          labelText: "Новый пароль",
          hintText: "Введите ваш новый пароль",
          floatingLabelBehavior: FloatingLabelBehavior.never),
    );
  }

  TextFormField buildNewPasswordRepeatedFormField(BuildContext context) {
    return TextFormField(
      controller: newPassRepeatedController,
      onSaved: (newValue) => newPasswordRepeated = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          //setNewRepeated(value);
          removeError(error: emptyPasswordError);
        } else if (value.length >= 8) {
          removeError(error: shortPasswordError);
        } else if (value == newPassController.text) {
          removeError(error: notMatchNewPasswordError);
        } 

  

        
        return;
      },
      validator: (value) {
        if (value.isEmpty)
          addError(error: emptyPasswordError);
        else if (value.length < 8)
          addError(error: shortPasswordError);
        else if (value != newPassController.text)
          //print(newPasswordRepeated)
          addError(error: notMatchNewPasswordError);

        return;
      },
      obscureText: true,
      decoration: InputDecoration(
          labelStyle: Theme.of(context)
              .textTheme
              .headline3
              .copyWith(color: Theme.of(context).textTheme.headline4.color),
          labelText: "Новый пароль",
          hintText: "Повторите ваш новый пароль",
          floatingLabelBehavior: FloatingLabelBehavior.never),
    );
  }
}
