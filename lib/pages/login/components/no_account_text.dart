import 'package:flutter/material.dart';
import 'package:photo_tips/pages/register/register_page.dart';

class NoAccountText extends StatelessWidget {
  const NoAccountText({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Нет аккаунта?  ",
              style: TextStyle(fontSize: 16)),
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, RegisterPage.routeName),
            child: Text("Зарегистрироваться",
                style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).accentColor)),
          ),
        ],
      ),
    );
  }
}