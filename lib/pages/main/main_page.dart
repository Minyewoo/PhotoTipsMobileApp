import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:photo_tips/pages/camera/camera_page.dart';
import 'package:photo_tips/pages/course/course_page.dart';
import 'package:photo_tips/pages/galery/galery_page.dart';
import 'package:photo_tips/pages/profile/profile_page.dart';
import 'package:photo_tips/screen_config.dart';

class MainPage extends StatefulWidget {
  static String routeName = "/main";
  final int selectedIndex;
  MainPage({Key key, this.selectedIndex}) : super(key: key);
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex;
  List<Widget> _widgetOptions = [
    CoursePage(),
    ProfilePage(),
    GaleryPage(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    _selectedIndex = widget.selectedIndex ?? 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenConfig().init(context);

    return Scaffold(
      extendBody: true,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
              border: Border(
                  top: BorderSide(
                color: Color(0xFFDDDDDD),
                width: 1,
              )),
            ),
            child: BottomNavigationBar(
              elevation: 0,
              items: [
                BottomNavigationBarItem(
                  title: Text("Курс"),
                  icon: Icon(Icons.import_contacts),
                  backgroundColor: Colors.transparent,
                ),
                BottomNavigationBarItem(
                  title: Text("Профиль"),
                  icon: Icon(Icons.person),
                  backgroundColor: Colors.transparent,
                ),
                BottomNavigationBarItem(
                  title: Text("Галерея"),
                  icon: Icon(Icons.photo_library),
                  backgroundColor: Colors.transparent,
                ),
              ],
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
            ),
          ),
        ),
      ),
    );
  }
}
