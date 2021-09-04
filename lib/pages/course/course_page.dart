import 'dart:async';
import 'dart:ui';

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:photo_tips/cubit/module_cubit.dart';
import 'package:photo_tips/cubit/submission_cubit.dart';
import 'package:photo_tips/cubit/submission_cubit.dart';
import 'package:photo_tips/data/models/module.dart';
import 'package:photo_tips/data/models/module_entry.dart';
import 'package:photo_tips/data/models/submission.dart';
import 'package:photo_tips/pages/camera/camera_page.dart';
import 'package:photo_tips/pages/camera/camera_page2.dart';
import 'package:photo_tips/pages/camera/camera_page3.dart';
import 'package:photo_tips/pages/camera/camera_page4.dart';
import 'package:photo_tips/pages/course/lesson_page.dart';
import 'package:photo_tips/pages/galery/galery_page.dart';
import 'package:photo_tips/pages/profile/profile_page.dart';
import 'package:photo_tips/screen_config.dart';

class CoursePage extends StatefulWidget {
  static String routeName = "/course";
  @override
  _CoursePageState createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  List<Widget> routeNames = [
    CoursePage(),
    ProfilePage(),
    GaleryPage(),
  ];

  int _selectedIndex = 0;

  List<Module> _modules = [];

  @override
  void initState() {
    super.initState();
    final moduleCubit = context.read<ModuleCubit>();
    moduleCubit.getAllModules();
    final submissionCubit = context.read<SubmissionCubit>();
    submissionCubit.getSubmissions();
  }

  void _onItemTapped(int index) {
    if (index != _selectedIndex)
      Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => routeNames[index],
            transitionDuration: Duration(seconds: 0),
          ));
  }

  int countEntries(ModuleEntryType type) {
    int count = 0;
    _modules.forEach((module) {
      module.entries.forEach((entry) {
        if (entry.type == type) count++;
      });
    });
    return count;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    ScreenConfig().init(context);
    return BlocConsumer<ModuleCubit, ModuleState>(
      listener: (context, state) {
        if (state is ModuleInitial)
          context.read<ModuleCubit>().getAllModules();
        else if (state is ModuleError) {
          Timer(
              Duration(seconds: 5), context.read<ModuleCubit>().getAllModules);

          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('${state.message}. Повтор через 5 секунд'),
            ),
          );
        } else if (state is ModuleLoaded) {
          _modules = state.modules;
        }
      },
      builder: (context, state) {
        /*if (state is ModuleInitial) {
          return buildLoadingPage(context);
        } else*/
        if (state is ModuleLoading) {
          return buildLoadingPage(context);
        } else if (state is ModuleLoaded) {
          return Scaffold(
            extendBodyBehindAppBar: true,
            extendBody: true,
            appBar: buildAppBarWithData(context),
            body: buildCoursePageWithData(context, state),
            //bottomNavigationBar: buildBottomNavigationBar(context),
          );
        }
      },
    );
  }

  Scaffold buildLoadingPage(BuildContext context) {
    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
      //bottomNavigationBar: buildBottomNavigationBar(context),
    );
  }

  Stack buildCoursePageWithData(BuildContext context, ModuleLoaded state) {
    var submissionsState = context.watch<SubmissionCubit>().state;
    List<Submission> submissions;
    if(submissionsState is SubmissionLoaded)
      submissions = submissionsState.submissions;
    else submissions = [];
    return Stack(
      children: [
        ScrollConfiguration(
          behavior: new ScrollBehavior()
            ..buildViewportChrome(context, null, AxisDirection.down),
          child: RefreshIndicator(
            displacement: 60,
            onRefresh: context.watch<ModuleCubit>().getAllModules,
            child: SingleChildScrollView(
              //physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(
                    height: 84,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 3.0, bottom: 8.0),
                            child: Text(
                              "Продолжить обучение",
                              style: Theme.of(context).textTheme.headline1,
                            ),
                          ),
                        ),
                        //SizedBox(height: 8),
                        buildExpandableModuleList(context, [state.modules.last]),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(top: 24.0, left: 3.0, bottom: 8.0),
                            child: Text(
                              "Модули",
                              style: Theme.of(context).textTheme.headline1,
                            ),
                          ),
                        ),
                        //SizedBox(height: 8),
                        buildExpandableModuleList(context, state.modules),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 56,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Container buildExpandableModuleList(
      BuildContext context, List<Module> modules) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Color(0xFFDDDDDD))),
      child: Column(
        children: List.generate(
          modules.length,
          (index) => ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: ModuleBlock(
              modules[index],
              controller: ExpandableController(),
              moduleIndex: modules[index].indexNumber,
              isFirst: index == 0,
              isLast: index == modules.length - 1,
              status: index == modules.length - 1
                  ? TaskStatus.beginned
                  : TaskStatus.passed,
            ),
          ),
        ),
      ),
    );
  }

  PreferredSize buildAppBarWithData(BuildContext context) {
    var theme = Theme.of(context);
    final lessonsCount = countEntries(ModuleEntryType.Lesson);
    final homeworksCount = countEntries(ModuleEntryType.Homework);
    return PreferredSize(
      preferredSize: Size.fromHeight(56),
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 32, sigmaY: 32),
          child: AppBar(
            bottom: PreferredSize(
                child: Container(
                  height: 1,
                  color: Color(0xFFDDDDDD),
                ),
                preferredSize: Size.fromHeight(1)),
            elevation: 0,
            automaticallyImplyLeading: false,
            flexibleSpace: SafeArea(
              child: Padding(
                padding: EdgeInsets.only(
                  right: 16,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ClipOval(
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => Navigator.pushNamed(
                              context, CameraPage4.routeName),
                          child: Container(
                            width: 56,
                            height: 56,
                            child: Icon(
                              Icons.camera_alt,
                              color: theme.textTheme.headline1.color,
                            ),
                          ),
                        ),
                      ),
                    ),
                    ProgressBar(
                      height: 24,
                      width: 152,
                      percents: 100,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 16, left: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Уроки",
                                style: theme.textTheme.headline4,
                              ),
                              Text(
                                "${lessonsCount}/${lessonsCount}",
                                //"0/${lessonsCount}",
                                style: theme.textTheme.headline2,
                              ),
                            ],
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Задания",
                              style: theme.textTheme.headline4,
                            ),
                            Text(
                              "5/5",
                              //"0/${homeworksCount}",
                              style: theme.textTheme.headline2,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  ClipRRect buildBottomNavigationBar(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 32, sigmaY: 32),
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
    );
  }
}

enum Placing { first, middle, last }
enum TaskStatus { initial, beginned, passed }

class ModuleBlock extends StatelessWidget {
  final ExpandableController controller;
  final Module _module;
  final int moduleIndex;
  final Placing placing;
  final GlobalKey key;
  final bool isFirst;
  final bool isLast;
  final TaskStatus status;

  const ModuleBlock(this._module,
      {GlobalKey this.key,
      this.controller,
      this.moduleIndex = 1,
      this.placing,
      this.isFirst = false,
      this.isLast = false,
      this.status = TaskStatus.initial})
      : super(key: key);

  int countEntries(ModuleEntryType type) {
    int count = 0;
    _module.entries.forEach((element) {
      if (element.type == type) count++;
    });
    return count;
  }

  String getEnumEnding(int count) {
    var ones = count % 10;
    if (count ~/ 10 < 1) if (count == 1)
      return "";
    else if (count >= 2 && count < 5)
      return "а";
    else
      return "ов";
    else if (ones == 1)
      return "ов";
    else if (ones >= 2 && ones < 5)
      return "а";
    else
      return "ов";
  }

  @override
  Widget build(BuildContext context) {
    var noDescription =
        _module.description == null || _module.description.length == 0;
    var theme = Theme.of(context);
    return ExpandableNotifier(
      controller: controller,
      child: Expandable(
        theme: ExpandableThemeData(crossFadePoint: 0.0),
        collapsed: GestureDetector(
          onTap: () {
            controller.toggle();
            //Scrollable.ensureVisible(key.currentContext);
          },
          child: Container(
            color: theme.primaryColor,
            height: 96,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildModuleCompletionPath(context, false),
                /*Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                        width: 56,
                        child: SvgPicture.asset(
                            "assets/icons/module_middle_complete.svg")),
                  ],
                ),*/
                Container(
                  width: 214,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                top: noDescription ? 33 : 14,
                                bottom: noDescription ? 0 : 2),
                            child: Text(
                              _module.name,
                              style: theme.textTheme.headline1,
                            ),
                          ),
                          Text(
                            _module.description,
                            softWrap: true,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodyText1,
                          ),
                        ],
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(bottom: noDescription ? 7 : 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "${countEntries(ModuleEntryType.Lesson) == 0 ? 3 : countEntries(ModuleEntryType.Lesson)} урок${getEnumEnding(countEntries(ModuleEntryType.Lesson))}",
                              style: theme.textTheme.subtitle1,
                            ),
                            Spacer(),
                            Text(
                              "${countEntries(ModuleEntryType.Homework) == 0 ? 1 : countEntries(ModuleEntryType.Homework)} домашнее задание",
                              style: theme.textTheme.subtitle1,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 56,
                      child: SvgPicture.asset(
                        "assets/icons/expand_arrow.svg",
                        color: theme.textTheme.headline1.color,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        expanded: Column(
          children: [
            InkWell(
              onTap: () => controller.toggle(),
              child: Container(
                color: theme.primaryColor,
                height: 96,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    buildModuleCompletionPath(context, true),
                    /*Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                            width: 56,
                            child: SvgPicture.asset(
                                "assets/icons/module_middle_complete.svg")),
                      ],
                    ),*/
                    Container(
                      width: 214,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    top: noDescription ? 33 : 14,
                                    bottom: noDescription ? 0 : 2),
                                child: Text(
                                  _module.name,
                                  style: theme.textTheme.headline1,
                                ),
                              ),
                              Text(
                                _module.description,
                                softWrap: true,
                                style: theme.textTheme.bodyText1,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 56,
                          child: SvgPicture.asset(
                            "assets/icons/collapse_arrow.svg",
                            color: theme.textTheme.headline1.color,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: List.generate(
                _module.entries.length,
                (index) => InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute<void>(
                        builder: (BuildContext context) {
                      return LessonPage(
                        _module.entries[index],
                        moduleIndex: moduleIndex,
                        entryIndex: _module.entries[index].indexNumber,
                        moduleName: _module.name,
                      );
                    }));
                  },
                  child: Container(
                    height: 64,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        buildModuleEntryCompletionPath(index, context),
                        Container(
                          width: 214,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${_module.entries[index].name}',
                                softWrap: true,
                                style: theme.textTheme.headline3,
                              ),
                            ],
                          ),
                          decoration:
                              index == _module.entries.length - 1 && !isLast
                                  ? BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                            color: Color(0xFFDFDFDF), width: 2),
                                      ),
                                    )
                                  : BoxDecoration(),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 56,
                              child: Text(
                                _module.entries[index].type ==
                                        ModuleEntryType.Lesson
                                    ? '44 мин'
                                    : '',
                                style: theme.textTheme.subtitle1,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container buildModuleEntryCompletionPath(int index, BuildContext context) {
    return Container(
      width: 56,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              "${moduleIndex}.${_module.entries[index].indexNumber}",
              style: TextStyle(
                color:
                    status == TaskStatus.beginned || status == TaskStatus.passed
                        ? Theme.of(context).accentColor
                        : Color(0xFFDFDFDF),
                fontFamily: 'PT Root UI',
                fontWeight: FontWeight.w600,
                fontSize: 12,
                //height: 16.0 / 12.0,
                letterSpacing: 0.1,
              ),
            ),
          ),
          status == TaskStatus.beginned
              ? Center(
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          width: 2.0, color: Theme.of(context).accentColor),
                    ),
                  ),
                )
              : Container(),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: 2,
              height: 21.33,
              decoration: BoxDecoration(
                color:
                    status == TaskStatus.beginned || status == TaskStatus.passed
                        ? Theme.of(context).accentColor
                        : Color(0xFFDFDFDF),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(1),
                  bottomRight: Radius.circular(1),
                ),
              ),
            ),
          ),
          !isLast || index != _module.entries.length - 1
              ? Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: 2,
                    height: 21.33,
                    decoration: BoxDecoration(
                      color: status == TaskStatus.beginned ||
                              status == TaskStatus.passed
                          ? Theme.of(context).accentColor
                          : Color(0xFFDFDFDF),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(1),
                        topRight: Radius.circular(1),
                      ),
                    ),
                  ),
                )
              : Container(),
          /*Center(
                                    child: SvgPicture.asset(
                                        "assets/icons/lesson_complete.svg"),
                                  ),*/
        ],
      ),
    );
  }

  Container buildModuleCompletionPath(BuildContext context, bool expanded) {
    return Container(
      width: 56,
      child: Stack(
        alignment: Alignment.center,
        children: [
          !isFirst
              ? Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    alignment: Alignment.topCenter,
                    width: 2,
                    height: 37,
                    decoration: BoxDecoration(
                      color: status == TaskStatus.beginned ||
                              status == TaskStatus.passed
                          ? Theme.of(context).accentColor
                          : Color(0xFFDFDFDF),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(1),
                        bottomRight: Radius.circular(1),
                      ),
                    ),
                  ),
                )
              : Container(),
          status == TaskStatus.beginned
              ? Center(
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          width: 2.0, color: Theme.of(context).accentColor),
                    ),
                  ),
                )
              : Container(),
          Center(
            child: Container(
              //width: 14.66,
              //height: 14.66,
              child: Icon(
                Icons.check,
                color: status == TaskStatus.passed
                    ? Theme.of(context).accentColor
                    : Color(0xFFDFDFDF),
              ),
            ),
          ),
          !isLast || expanded
              ? Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: 2,
                    height: 37,
                    decoration: BoxDecoration(
                      color: status == TaskStatus.beginned ||
                              status == TaskStatus.passed
                          ? Theme.of(context).accentColor
                          : Color(0xFFDFDFDF),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(1),
                        topRight: Radius.circular(1),
                      ),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}

class ProgressBar extends StatelessWidget {
  final double height;
  final double width;
  final int percents;
  double _progressWidth;
  double _borderRadius;
  double _fontSize;
  ProgressBar({
    Key key,
    this.height,
    this.width,
    this.percents,
  }) : super(key: key) {
    var minWidth = width * (32.78 / 149.0);

    _progressWidth = width * percents * 0.01;
    _progressWidth = _progressWidth > minWidth ? _progressWidth : minWidth;

    _borderRadius = height * (63.0 / 26.0);

    _fontSize = height * (12.0 / 26.0);
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Stack(
      children: [
        Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(_borderRadius),
            color: Color(0xFFDFDFDF),
          ),
        ),
        Container(
          height: height,
          width: _progressWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(_borderRadius),
            color: theme.accentColor,
          ),
          child: Center(
            child: Text(
              "$percents%",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: theme.primaryColor,
                fontFamily: 'PT Root UI',
                fontSize: _fontSize,
                height: 1.22,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
