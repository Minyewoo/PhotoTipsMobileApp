import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_tips/cubit/auth_cubit.dart';
import 'package:photo_tips/pages/course/course_page.dart';
import 'package:photo_tips/pages/main/main_page.dart';
import 'components/body.dart';

class LoginPage extends StatelessWidget {
  static String routeName = '/login';

  @override
  Widget build(BuildContext context) {
    var pageContent = <Widget>[
      buildLoginPage(context),
    ];
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSignedIn)
            Navigator.popAndPushNamed(context, MainPage.routeName);
          if (state is AuthError) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is AuthSigningIn || state is AuthSignedIn) {
            pageContent.add(buildSigningInOverlay(context));
          }
          return Stack(
            children: pageContent,
          );
        },
      ),
    );
  }

  Container buildSigningInOverlay(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor.withOpacity(0.9),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget buildLoginPage(BuildContext context) {
    return Column(children: [
      AppBar(backgroundColor: Theme.of(context).scaffoldBackgroundColor,),
      Body(),
    ]);
  }
}
