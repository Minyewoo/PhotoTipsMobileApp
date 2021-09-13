import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path/path.dart';
import 'package:photo_tips/constants.dart';
import 'package:photo_tips/data/models/lecture_content.dart';
import 'package:photo_tips/data/models/module_entry.dart';
import 'package:photo_tips/pages/camera/camera_page.dart';
import 'package:photo_tips/pages/course/course_page.dart';
import 'package:photo_tips/screen_config.dart';
import 'package:photo_tips/widgets/custom_button.dart';
import 'package:video_player/video_player.dart';

class LessonPage extends StatefulWidget {
  final ModuleEntry _entry;
  final int moduleIndex;
  final int entryIndex;
  final String moduleName;
  const LessonPage(this._entry,
      {Key key,
      this.moduleIndex = 1,
      this.entryIndex = 1,
      this.moduleName = 'Модуль'})
      : super(key: key);

  @override
  _LessonPageState createState() => _LessonPageState();
}

class _LessonPageState extends State<LessonPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  ModuleEntry _entry;
  String _moduleName;
  int _moduleIndex;
  int _entryIndex;
  @override
  void initState() {
    super.initState();

    _entry = widget._entry;
    _moduleIndex = widget.moduleIndex;
    _entryIndex = widget.entryIndex;
    _moduleName = widget.moduleName;

    _tabController = new TabController(vsync: this, length: 2)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            _moduleName,
            style: Theme.of(context).textTheme.headline5,
          ),
          bottom: tryBuildSubHeader(context),
        ),
        body: buildBody(
            context) /*_entry.type != ModuleEntryType.Homework
            ? buildTabBarView(context)
            : buildLectureTab(context, _entry?.textLecture)*/
        ,
      ),
    );
  }

  PreferredSizeWidget tryBuildSubHeader(BuildContext context) {
    var hasEmptyTab =
        _entry.videoLecture.length == 0 || _entry.textLecture.length == 0;
    return PreferredSize(
      preferredSize: Size.fromHeight(hasEmptyTab ? 0 : 57),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Color(0xFFDDDDDD),
            ),
          ),
        ),
        child: hasEmptyTab ? null : tryBuildTabBar(context),
      ),
    );
  }

  Widget tryBuildTabBar(BuildContext context) {
    if (_entry.videoLecture.length == 0 || _entry.textLecture.length == 0)
      return Container();
    else
      return buildTabBar(context);
  }

  Widget buildBody(BuildContext context) {
    if (_entry.videoLecture.length == 0)
      return buildLectureTab(context, _entry?.textLecture);
    else if (_entry.textLecture.length == 0)
      return buildLectureTab(context, _entry?.videoLecture);
    else
      return buildTabBarView(context);
  }

  TabBarView buildTabBarView(BuildContext context) {
    return TabBarView(
      controller: _tabController,
      children: [
        buildLectureTab(context, _entry?.videoLecture),
        buildLectureTab(context, _entry?.textLecture),
      ],
    );
  }

  TabBar buildTabBar(BuildContext context) {
    return TabBar(
      controller: _tabController,
      labelColor: Theme.of(context).accentColor,
      indicatorWeight: 2.33,
      indicatorPadding: EdgeInsets.symmetric(
        horizontal: 14.4,
      ),
      tabs: [
        Tab(
          icon: SvgPicture.asset(
            'assets/icons/video.svg',
            color: _tabController.index == 0
                ? Theme.of(context).accentColor
                : Color(0xFF878787),
          ),
        ),
        Tab(
          icon: SvgPicture.asset(
            'assets/icons/text.svg',
            color: _tabController.index == 1
                ? Theme.of(context).accentColor
                : Color(0xFF878787),
          ),
        ),
      ],
    );
  }

  SingleChildScrollView buildLectureTab(
      BuildContext context, List<LectureContent> content) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Color(0xFFDDDDDD))),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 13),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _entry.type != ModuleEntryType.Homework
                          ? '$_moduleIndex.$_entryIndex ${_entry?.name}'
                          : _entry?.name,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    _entry.description != null && _entry.description != ""
                        ? Padding(
                            padding: const EdgeInsets.only(top: 13.0),
                            child: Text(_entry.description),
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
          ),
          buildLecture(context, content),
          _entry.additionalInfo?.length > 0
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Color(0xFFDDDDDD))),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 13),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 13.0),
                            child: Text(
                              "Дополнительная информация",
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ),
                          Text(_entry.additionalInfo),
                        ],
                      ),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  Column buildLecture(BuildContext context, List<LectureContent> content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Color(0xFFDDDDDD))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: content != null && content?.length != 0
                  ? List.generate(
                      content.length,
                      (index) {
                        var lectureContent = content[index];
                        switch (lectureContent.type) {
                          case ContentType.Text:
                            return Padding(
                              padding: const EdgeInsets.all(16),
                              child: Text(
                                lectureContent.content,
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            );

                          case ContentType.Image:
                            var first = index == 0;
                            var last = index == (content.length - 1);
                            return ClipRRect(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(first ? 8 : 0),
                                  bottom: Radius.circular(last ? 8 : 0)),
                              child: Container(
                                //height: 320,
                                width: double.infinity,
                                color: Color(0xFFDFDFDF),
                                child: Image.network(
                                  '${serverUrl}/${lectureContent.content}',
                                  fit: BoxFit.contain,
                                ),
                              ),
                            );

                          case ContentType.Video:
                            var first = index == 0;
                            var last = index == (content.length - 1);
                            return ClipRRect(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(first ? 8 : 0),
                                  bottom: Radius.circular(last ? 8 : 0)),
                              child: Container(
                                  color: Color(0xFFDFDFDF),
                                  width: double.infinity,
                                  child: VideoPlayerWidget(
                                      '${serverUrl}/${lectureContent.content}')),
                            );
                          default:
                            return Container();
                        }
                      },
                    )
                  : [],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(
              16, 40, 16, _entry.type != ModuleEntryType.Homework ? 66 : 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {},
                child: Container(
                  width: 151,
                  height: 36,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.arrow_back_ios),
                      Text(
                        "Предыдущий урок",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ],
                  ),
                ),
              ),
              _entry.type != ModuleEntryType.Homework
                  ? InkWell(
                      onTap: () {},
                      child: Container(
                        width: 151,
                        height: 36,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Следующий урок",
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            Icon(Icons.arrow_forward_ios),
                          ],
                        ),
                      ),
                    )
                  : InkWell(
                      onTap: () {
                      //    return  Navigator.of(context).push(MaterialPageRoute<void>(
                      //    builder: (BuildContext context) =>CameraPage4(
                      //      moduleEntryId: _entry.id,
                      //  )));
                      Navigator.pushNamed(context, CameraPage.routeName);
                      },
                      
                          //
                      child: Container(
                        width: 151,
                        height: 36,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Сделать фото",
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            Icon(Icons.camera_alt),
                          ],
                        ),
                      ),
                    ),
            ],
          ),
        ),
        _entry.type != ModuleEntryType.Homework
            ? Container()
            : Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 36, bottom: 54),
                  child: CustomButton(
                    width: 304,
                    height: 48,
                    borderRadius: BorderRadius.circular(4),
                    tapColor: Color(
                        Theme.of(context).textTheme.headline1.color.value -
                            0xFFA0A0A0),
                    backgroundColor: Theme.of(context).accentColor,
                    textColor: Theme.of(context).primaryColor,
                    fontSize: Theme.of(context).textTheme.headline1.fontSize,
                    title: "Следующий модуль",
                    onPressed: () =>
                        Navigator.pushNamed(context, CoursePage.routeName),
                  ),
                ),
              ),
      ],
    );
  }
}

class VideoPlayerWidget extends StatefulWidget {
  final String videoUri;
  VideoPlayerWidget(this.videoUri, {Key key}) : super(key: key);

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUri)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        _controller.value.initialized
            ? GestureDetector(
                onTap: () async {
                  if (_controller.value.position ==
                      _controller.value.duration) {
                    await _controller.seekTo(Duration.zero);
                    _controller.play();
                  } else
                    _controller.value.isPlaying
                        ? _controller.pause()
                        : _controller.play();
                  setState(() {});
                },
                child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: Stack(
                    children: [
                      VideoPlayer(_controller),
                      (_controller.value.position ==
                                  _controller.value.duration ||
                              !_controller.value.isPlaying)
                          ? Container(
                              width: double.infinity,
                              height: double.infinity,
                              color: Color(0xFFDFDFDF).withOpacity(0.5),
                              child: Icon(
                                Icons.play_arrow,
                                color: Color(0xFFDFDFDF),
                                size: 48,
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
              )
            : Container(
                height: 184, child: Center(child: CircularProgressIndicator())),
      ],
    );
  }
}
