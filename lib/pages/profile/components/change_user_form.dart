import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_tips/constants.dart';
import 'package:photo_tips/cubit/auth_cubit.dart';
import 'package:photo_tips/cubit/user_cubit.dart';
import 'package:photo_tips/data/repositories/user_repository.dart';
import 'package:photo_tips/pages/course/course_page.dart';
import 'package:photo_tips/widgets/custom_button.dart';
import 'package:photo_tips/widgets/form_error.dart';

class ChangeUserForm extends StatefulWidget {
  final String name;
  final String email;
  final String phoneNumber;

  const ChangeUserForm({Key key, this.name, this.email, this.phoneNumber}) : super(key: key);
  @override
  _ChangeUserFormState createState() => _ChangeUserFormState();
}

class _ChangeUserFormState extends State<ChangeUserForm> {
  final _formKey = GlobalKey<FormState>();
  String name;
  String email;
  String phoneNumber;

  @override
  void initState() {
    name = widget.name;
    email = widget.email;
    phoneNumber = widget.phoneNumber;
    super.initState();
  }

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

  Future<void> changeUser(BuildContext context) async {
    var state = context.read<AuthCubit>().state;
    if (state is AuthSignedIn) {
      try {
        var token = await ApiUserRepository()
            .changeInfo(state.token, name, email, phoneNumber);
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text("Данные изменены"),
        ));
        context.read<UserCubit>().getUser(token);
      } catch (e) {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(e.toString()),
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
            "Персональная информация",
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
        buildNameFormField(),
        buildEmailFormField(),
        buildPhoneNumberField(),
        SizedBox(height: 16),
        FormError(errors: errors),
        SizedBox(height: errors.length == 0 ? 0 : 16),
        CustomButton(
          width: 296,
          height: 48,
          borderRadius: BorderRadius.circular(4),
          tapColor: Color(Theme.of(context).accentColor.value - 0x000F0F0F),
          backgroundColor: Theme.of(context).accentColor,
          textColor: Color(0xFFF5F5F5),
          fontSize: Theme.of(context).textTheme.headline1.fontSize,
          title: 'Сохранить',
          onPressed: () {
            if (_formKey.currentState.validate()) {
              _formKey.currentState.save();
              // if(email == null)
              // {
              //   var state = context.read<UserCubit>().state;
              //   if(state is UserLoaded)
              //     email = state.user.email;
              // }
              if (errors.length == 0) changeUser(context);
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
      controller: TextEditingController(text: '${name ?? ""}'),
      onSaved: (newValue) => name = newValue,
      onChanged: (value) {
       
        return;
      },
      validator: (value) {
        //if (value.isEmpty) addError(error: emptyPasswordError);
        //else if (value.length < 8) addError(error: shortPasswordError);
        return;
      },
      decoration: InputDecoration(
          labelText: "Имя",
          hintText: "Введите ваше имя",
          floatingLabelBehavior: FloatingLabelBehavior.never),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      controller: TextEditingController(text: '${email ?? ""}'),
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: invalidEmailError);
        }
        return;
      },
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value.isNotEmpty) if (!emailValidatorRegExp.hasMatch(value))
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

  TextFormField buildPhoneNumberField() {
    return TextFormField(
      controller: TextEditingController(text: '${phoneNumber ?? ""}'),
      onSaved: (newValue) => phoneNumber = newValue,
      onChanged: (value) {
        return;
      },
      keyboardType: TextInputType.phone,
      validator: (value) {
        return;
      },
      decoration: InputDecoration(
        labelText: "Номер телефона",
        hintText: "Введите ваш номер телефона",
        floatingLabelBehavior: FloatingLabelBehavior.never,
      ),
    );
  }
}
