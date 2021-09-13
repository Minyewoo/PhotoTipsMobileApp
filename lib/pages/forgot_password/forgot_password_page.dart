import 'package:flutter/material.dart';

import 'components/body.dart';

class ForgorPasswordPage extends StatelessWidget {
  static String routeName = '/forgot_password';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(backgroundColor: Theme.of(context).scaffoldBackgroundColor,),
      body: Body(),
    );
  }
}