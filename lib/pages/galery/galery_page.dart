import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:photo_tips/constants.dart';
import 'package:photo_tips/cubit/auth_cubit.dart';
import 'package:photo_tips/cubit/module_cubit.dart';
import 'package:photo_tips/cubit/photo_cubit.dart';
import 'package:photo_tips/cubit/photo_cubit.dart';
import 'package:photo_tips/cubit/submission_cubit.dart';
import 'package:photo_tips/cubit/user_cubit.dart';
import 'package:photo_tips/data/models/photo.dart';
import 'package:photo_tips/data/models/submission.dart';
import 'package:photo_tips/data/repositories/photo_repository.dart';
import 'package:photo_tips/pages/course/course_page.dart';
import 'package:photo_tips/pages/profile/profile_page.dart';
import 'dart:ui';

import 'package:share/share.dart';

class GaleryPage extends StatefulWidget {
  static String routeName = "/galery";
  @override
  _GaleryPageState createState() => _GaleryPageState();
}

class _GaleryPageState extends State<GaleryPage> {
  List<Widget> images;

  List<String> routeNames = [
    CoursePage.routeName,
    ProfilePage.routeName,
    GaleryPage.routeName,
  ];
  int _selectedIndex = 2;

  void _onItemTapped(int index) {
    if (index != _selectedIndex)
      Navigator.pushNamed(context, routeNames[index]);
  }

  @override
  void initState() {
    var photoCubit = context.read<PhotoCubit>();

    if (photoCubit.state is PhotoInitial) {
      var authState = context.read<AuthCubit>().state;
      if (authState is AuthSignedIn) photoCubit.getPhotos(authState.token);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: PreferredSize(
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        "Мои фотографии",
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                    ClipOval(
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            width: 56,
                            height: 56,
                            child: SvgPicture.asset(
                              'assets/icons/peek.svg',
                              color:
                                  Theme.of(context).textTheme.headline5.color,
                              fit: BoxFit.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      body: BlocConsumer<SubmissionCubit, SubmissionState>(
        listener: (context, state) {
          if (state is SubmissionInitial &&
              context.read<AuthCubit>().state is AuthSignedIn) {
            context.read<SubmissionCubit>().getSubmissions();
          }
        },
        builder: (context, state) {
          if (state is SubmissionLoaded)
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
              child: GridView.count(
                physics: BouncingScrollPhysics(),
                mainAxisSpacing: 1,
                crossAxisSpacing: 1,
                crossAxisCount: 3,
                children: state.submissions
                    .map((submission) => HeroAnimation(
                          submission: submission,
                        ))
                    .toList(),
              ),
            );
          else
            return Center(
              child: Text("Галерея пуста"),
            );
        },
      ),
      /*body: BlocConsumer<PhotoCubit, PhotoState>(
        listener: (context, state) {
          if (state is PhotoInitial) {
            var authState = context.read<AuthCubit>().state;
            if (authState is AuthSignedIn)
              context.read<PhotoCubit>().getPhotos(authState.token);
          }
        },
        builder: (context, state) {
          if (state is PhotoLoaded)
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
              child: GridView.count(
                physics: BouncingScrollPhysics(),
                mainAxisSpacing: 1,
                crossAxisSpacing: 1,
                crossAxisCount: 3,
                children: state.photos
                    .map((photo) => HeroAnimation(
                          photo: photo,
                        ))
                    .toList(),
              ),
            );
          else
            return Center(
              child: Text("Галерея пуста"),
            );
        },
      ),*/
      /*bottomNavigationBar: ClipRRect(
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
      ),*/
    );
  }
}

class PhotoHero extends StatelessWidget {
  const PhotoHero({Key key, this.photo, this.onTap, this.fit})
      : super(key: key);

  final String photo;
  final VoidCallback onTap;
  final BoxFit fit;
  Widget build(BuildContext context) {
    return Container(
      child: Hero(
        tag: photo,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: buildImage(context),
          ),
        ),
      ),
    );
  }

  Widget buildImage(BuildContext context) {
    var color = Theme.of(context).textTheme.bodyText1.color;
    return Image.network(
      photo,
      fit: fit,
      loadingBuilder: (context, child, loadingProgress) => loadingProgress ==
              null
          ? child
          : Center(
              child: Container(
                  color: Colors.grey[
                      350]) /*CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes
                        : null,
                  ),*/
              ),
      errorBuilder: (context, error, stackTrace) => Container(
        child: Center(
          child: Icon(
            Icons.image,
            color: color,
          ),
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: color,
          ),
        ),
      ),
    );
  }
}

class HeroAnimation extends StatelessWidget {
  final Submission submission;
  //final String thumbUri;
  const HeroAnimation({Key key, this.submission}) : super(key: key);

  Widget build(BuildContext context) {
    //var timeDilation = 5.0; // 1.0 means normal animation speed.

    return PhotoHero(
      fit: BoxFit.cover,
      photo: '$serverUrl/${submission.photo.thumbnailUrl}',
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute<void>(builder: (BuildContext context) {
          return PhotoDetails(submission: submission);
        }));
      },
    );
  }
}

class PhotoDetails extends StatefulWidget {
  final Submission submission;
  const PhotoDetails({
    Key key,
    @required this.submission,
  }) : super(key: key);
  @override
  _PhotoDetailsState createState() =>
      _PhotoDetailsState(submission: submission);
}

class _PhotoDetailsState extends State<PhotoDetails> {
  final Submission submission;
  _PhotoDetailsState({
    @required this.submission,
  });
  TransformationController controller = TransformationController();

  /*void deletePhoto(BuildContext context, String id) {
    ApiPhotoRepository().deletePhoto(id).then((_) {
      var photoCubit = context.read<PhotoCubit>();
      var state = photoCubit.state;
      if (state is PhotoLoaded && state.photos.remove(photo)) {
        photoCubit.emit(PhotoState.loading());
        photoCubit.emit(PhotoState.loaded(state.photos));
        Navigator.of(context).pop();
      }
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
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
              //automaticallyImplyLeading: false,
              flexibleSpace: SafeArea(
                child: Container(),
              ),
            ),
          ),
        ),
      ),
      body: Center(
        child: InteractiveViewer(
          //panEnabled: false,
          transformationController: controller,
          onInteractionEnd: (ScaleEndDetails endDetails) {
            controller.value = Matrix4.identity();
          },
          child: PhotoHero(
            fit: BoxFit.fitWidth,
            photo: '$serverUrl/${submission.photo.fileUrl}',
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute<void>(builder: (BuildContext context) {
                return PhotoRecall(submission: submission);
              }));
            },
          ),
        ),
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Share.share(
                      '$serverUrl/${submission.photo.fileUrl}',
                      subject: "Отправлено из приложения PhotoTips",
                    );
                  },
                  child: Container(
                    width: 56,
                    height: 56,
                    child: Icon(
                      Icons.share,
                      color: Theme.of(context).textTheme.headline1.color,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  /*=> deletePhoto(context, photo.id),*/
                  child: Container(
                    width: 56,
                    height: 56,
                    child: Icon(
                      Icons.delete,
                      color: Theme.of(context).textTheme.headline1.color,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PhotoRecall extends StatelessWidget {
  final Submission submission;

  String getModuleName(BuildContext context, int moduleEntryId) {
    var state = context.read<ModuleCubit>().state;
    if (state is ModuleLoaded)
      return state.modules
          .firstWhere((module) =>
              module.entries.any((entry) => entry.id == moduleEntryId))
          .name;
    else
      return "Модуль N";
  }

  const PhotoRecall({Key key, this.submission}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
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
              //automaticallyImplyLeading: false,
              flexibleSpace: SafeArea(
                child: Container(),
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: PhotoHero(
                      fit: BoxFit.fitWidth,
                      photo: '$serverUrl/${submission.photo.fileUrl}',
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute<void>(
                            builder: (BuildContext context) {
                          return PhotoRecall(submission: submission);
                        }));
                      },
                    ),
                ),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Сведения о фото",
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          getModuleName(context, submission.moduleEntryId),
                          style: Theme.of(context).textTheme.headline3,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            Icon(Icons.calendar_today),
                            SizedBox(width: 19),
                            Text(
                              "Ср. 20 окт. 2020 г., 13:56",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1
                                  .copyWith(letterSpacing: 0.5),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            Icon(Icons.smartphone),
                            SizedBox(width: 19),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Name.jpeg",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1
                                      .copyWith(letterSpacing: 0.5),
                                ),
                                Text(
                                  "12.2 Мпикс. 4032×3024 1,9 МБ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1
                                      .copyWith(letterSpacing: 0.5),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Обратная связь",
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 4.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Оценка:",
                              style: Theme.of(context).textTheme.headline3,
                            ),
                            SizedBox(width: 6),
                            Text(
                              "${submission.mark}",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1
                                  .copyWith(
                                      color: Theme.of(context).accentColor),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 4.0),
                        child: Text(
                          "Комментарий:",
                          style: Theme.of(context).textTheme.headline3,
                        ),
                      ),
                      Container(
                        child: Text(
                          submission.comment,
                          style: Theme.of(context)
                              .textTheme
                              .headline1
                              .copyWith(fontSize: 18),
                        ),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Color(0xFF282828),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
