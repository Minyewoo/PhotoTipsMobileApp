import 'package:flutter/material.dart';
import 'package:photo_tips/pages/profile/components/new_password_form.dart';
import 'package:photo_tips/widgets/custom_button.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Настройки",
          style: Theme.of(context).textTheme.headline5,
        ),
        bottom: PreferredSize(
            child: Container(
              height: 1,
              color: Color(0xFFDDDDDD),
            ),
            preferredSize: Size.fromHeight(1)),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildNotificationSettings(context),
            buildThemeSettings(context),
            buildPasswordChanging(context),
          ],
        ),
      ),
    );
  }

  Padding buildPasswordChanging(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(16.0).copyWith(top: 8),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Color(0xFFDDDDDD))),
        child: Padding(
          padding: EdgeInsets.all(16),
          child:
              NewPasswordForm(), /* Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 24,
                  child: Text(
                    "Изменение пароля",
                    style: theme.headline1,
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Текущий пароль",
                    labelStyle:
                        theme.headline3.copyWith(color: theme.headline4.color),
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    suffixIcon: IconButton(
                        icon: Icon(
                          Icons.visibility_off,
                          color: Theme.of(context).textTheme.headline1.color,
                        ),
                        onPressed: () {}),
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Новый пароль",
                    labelStyle:
                        theme.headline3.copyWith(color: theme.headline4.color),
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    suffixIcon: IconButton(
                        icon: Icon(
                          Icons.visibility_off,
                          color: Theme.of(context).textTheme.headline1.color,
                        ),
                        onPressed: () {}),
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Повторите новый пароль",
                    labelStyle:
                        theme.headline3.copyWith(color: theme.headline4.color),
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    suffixIcon: IconButton(
                        icon: Icon(
                          Icons.visibility_off,
                          color: Theme.of(context).textTheme.headline1.color,
                        ),
                        onPressed: () {}),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: CustomButton(
                    width: 328,
                    height: 48,
                    borderRadius: BorderRadius.circular(4),
                    tapColor: Color(
                        Theme.of(context).textTheme.headline1.color.value -
                            0xFFA0A0A0),
                    backgroundColor: Theme.of(context).accentColor,
                    textColor: Theme.of(context).primaryColor,
                    fontSize: Theme.of(context).textTheme.headline1.fontSize,
                    title: "Изменить",
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),*/
        ),
      ),
    );
  }

  Padding buildNotificationSettings(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Color(0xFFDDDDDD))),
        child: Padding(
          padding: EdgeInsets.all(16).copyWith(right: 2),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 24,
                  child: Text(
                    "Уведомления",
                    style: theme.headline1,
                  ),
                ),
                SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Включить уведомления",
                      style: theme.headline3,
                    ),
                    Container(
                        height: 20,
                        child: Switch(
                          value: true,
                          onChanged: (_) {},
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding buildThemeSettings(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(16.0).copyWith(top: 8),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Color(0xFFDDDDDD))),
        child: Padding(
          padding: EdgeInsets.all(16).copyWith(right: 2),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 24,
                  child: Text(
                    "Стиль оформления",
                    style: theme.headline1,
                  ),
                ),
                SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Тёмный режим",
                      style: theme.headline3,
                    ),
                    Container(
                      height: 20,
                      child: Switch(value: true, onChanged: (_) {}),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Использовать настройки устройства",
                      style: theme.headline3,
                    ),
                    Container(
                      height: 20,
                      child: Switch(value: true, onChanged: (_) {}),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
