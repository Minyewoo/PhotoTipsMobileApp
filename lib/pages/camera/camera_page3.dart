import 'dart:async';
import 'dart:io';
import 'dart:math' show pi, pow;
import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:native_device_orientation/native_device_orientation.dart';
import 'package:photo_tips/camera_config.dart';
import 'package:photo_tips/cubit/auth_cubit.dart';
import 'package:photo_tips/cubit/photo_cubit.dart';
import 'package:photo_tips/data/repositories/photo_repository.dart';
import 'package:photo_tips/pages/camera/components/setting_slider.dart';
import 'package:photo_tips/pages/main/main_page.dart';
import 'package:photo_tips/screen_config.dart';
import 'package:sensors/sensors.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CameraPage3 extends StatefulWidget {
  static String routeName = "/camera3";
  @override
  _CameraPage3State createState() => _CameraPage3State();
}

/// Returns a suitable camera icon for [direction].
IconData getCameraLensIcon(CameraLensDirection direction) {
  switch (direction) {
    case CameraLensDirection.back:
      return Icons.camera_rear;
    case CameraLensDirection.front:
      return Icons.camera_front;
    case CameraLensDirection.external:
      return Icons.camera;
  }
  throw ArgumentError('Unknown lens direction');
}

void logError(String code, String message) =>
    print('Error: $code\nError Message: $message');

class _CameraPage3State extends State<CameraPage3>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  CameraController controller;
  VideoPlayerController videoController;
  VoidCallback videoPlayerListener;
  XFile imageFile;
  XFile videoFile;
  bool enableAudio = true;
  double _minAvailableExposureOffset = 0.0;
  double _maxAvailableExposureOffset = 0.0;
  int _minAvailableExposureTime = 0;
  int _maxAvailableExposureTime = 0;
  int _minAvailableIsoValue = 0;
  int _maxAvailableIsoValue = 0;
  double _currentExposureOffset = 0.0;
  int _currentExposureTime = 0;
  int _currentIsoValue = 100;
  double _horizonLevel = 0.0;
  double _rotation = 0.0;
  AnimationController _iconRotationAnimationController;
  Animation<double> _iconRotationAnimation;
  Tween<double> _tween;
  double _minAvailableZoom;
  double _maxAvailableZoom;
  double _currentScale = 1.0;
  double _baseScale = 1.0;
  ExposureMode _exposureMode = ExposureMode.auto;
  FlashMode _flashMode = FlashMode.off;
  WbMode _wbMode = WbMode.auto;
  IsoMode _isoMode = IsoMode.auto;
  FocusMode _focusMode = FocusMode.auto;
  bool _isSettingsShown = false;
  bool _isGridVisible = false;
  bool _isHorizonVisible = false;
  // Counting pointers (number of user fingers on screen)
  int _pointers = 0;
  int _currentSettingIndex = null;
  StreamSubscription<NativeDeviceOrientation> _orientationSubscribtion;
  StreamSubscription<GyroscopeEvent> _gyroscopeSubscription;

  Map<WbMode, String> wbValues = {
    WbMode.auto: 'AUTO',
    WbMode.incandescent: '2300K',
    WbMode.fluorescent: '4000K',
    WbMode.warm_fluorescent: '4500K',
    WbMode.daylight: '5200K',
    WbMode.cloudy_daylight: '6500K',
    WbMode.twilight: '7000K',
    WbMode.shade: '8000K',
  };

  Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _iconRotationAnimationController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this, value: 0.5);

    _tween = Tween(begin: -pi / 2.0, end: pi / 2.0);

    _iconRotationAnimation = _tween.animate(_iconRotationAnimationController)
      ..addListener(() {
        setState(() {});
      });

    _orientationSubscribtion = NativeDeviceOrientationCommunicator()
        .onOrientationChanged(
      useSensor: true,
    )
        .listen((event) {
      rotateIcons(event);
    });

    onNewCameraSelected(CameraConfig.cameras.first);
  }

  void changeSettingIndex(int index) {
    setState(() {
      _currentSettingIndex = index;
    });
  }

  void rotateIcons(NativeDeviceOrientation orientation) {
    double progress;
    switch (orientation) {
      case NativeDeviceOrientation.portraitUp:
        progress = 0.5;
        _rotation = 0;
        break;
      case NativeDeviceOrientation.landscapeLeft:
        progress = 1.0;
        _rotation = pi / 2.0;
        break;
      case NativeDeviceOrientation.landscapeRight:
        progress = 0.0;
        _rotation = -pi / 2.0;
        break;
      case NativeDeviceOrientation.portraitDown:
        return;
      case NativeDeviceOrientation.unknown:
        return;
    }

    //_tween.begin = _tween.end;
    //_animationController.reset();
    //_tween.end = rotation;
    _iconRotationAnimationController.animateTo(
      progress,
      curve: Curves.easeInOut,
    );
  }

  String stringifyExposureMode(ExposureMode mode) {
    Map<ExposureMode, String> values = {
      ExposureMode.auto: 'AUTO',
      ExposureMode.locked: 'LOCKED',
    };
    return values[mode];
  }

  String stringifyIsoMode(IsoMode mode) {
    Map<IsoMode, String> values = {
      IsoMode.auto: 'AUTO',
      IsoMode.locked: 'LOCKED',
    };
    return values[mode];
  }

  String stringifyWbMode(WbMode mode) {
    return wbValues[mode];
  }

  String stringifyFocusMode(FocusMode mode) {
    Map<FocusMode, String> values = {
      FocusMode.auto: 'AUTO',
      FocusMode.locked: 'USER'
    };
    return values[mode];
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _orientationSubscribtion?.cancel();
    _iconRotationAnimationController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // App state changed before we got the chance to initialize.
    if (controller == null || !controller.value.isInitialized) {
      return;
    }
    if (state == AppLifecycleState.inactive) {
      controller?.dispose();
    } else if (state == AppLifecycleState.resumed) {
      if (controller != null) {
        onNewCameraSelected(controller.description);
      }
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Stack buildGrid() {
    return Stack(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              color: Color(0xFFF5F5F5),
              width: 1,
            ),
            Container(
              color: Color(0xFFF5F5F5),
              width: 1,
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              color: Color(0xFFF5F5F5),
              height: 1,
            ),
            Container(
              color: Color(0xFFF5F5F5),
              height: 1,
            ),
          ],
        ),
      ],
    );
  }

  Transform buildHorizonLevel() {
    return Transform.rotate(
      angle: _rotation,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              color: Color(0xFFF5F5F5),
              height: 1,
              width: ScreenConfig.screenWidth * 0.35,
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  //color: Colors.transparent,
                  height: 9,
                  width: 20,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Color(0xFFF5F5F5)),
                  ),
                ),
                Transform.rotate(
                  angle: _horizonLevel,
                  child: Container(
                    color: Color(0xFFF5F5F5),
                    height: 1,
                    width: ScreenConfig.screenWidth * 0.28,
                  ),
                ),
              ],
            ),
            Container(
              color: Color(0xFFF5F5F5),
              height: 1,
              width: ScreenConfig.screenWidth * 0.35,
            ),
          ],
        ),
      ),
    );
  }

  void resetSettings() {
    _currentSettingIndex = null;
    setIsoMode(IsoMode.auto);
    setFlashMode(FlashMode.off);
    setExposureMode(ExposureMode.auto);
    controller.setFocusPoint(null);
    setFocusMode(FocusMode.auto);
    setWbMode(WbMode.auto);

    resetIsoValue();
    resetExposureOffset();
    resetExposureTime();
  }

  void resetExposureTime() {
    setExposureTime(
        (_maxAvailableExposureTime - _minAvailableExposureTime) ~/ 2 +
            _minAvailableExposureTime);
  }

  void resetExposureOffset() {
    setExposureOffset(0.0);
  }

  void resetIsoValue() {
    setIsoValue(100);
  }

  Widget buildSettings() {
    switch (_currentSettingIndex) {
      case 0:
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () {
                    setExposureMode(ExposureMode.auto);
                    resetExposureOffset();
                    controller.setIsoMode(IsoMode.auto);
                    //controller.setExposureOffset(null);
                    //_currentExposureOffset = 0.0;
                  },
                  child: Container(
                    width: 60,
                    height: 20,
                    child: Center(
                      child: Text(
                        stringifyExposureMode(ExposureMode.auto),
                        style: TextStyle(
                          color: _exposureMode == ExposureMode.auto
                              ? Colors.yellow
                              : Color(0xFFF5F5F5),
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => setExposureMode(ExposureMode.locked),
                  child: Container(
                    width: 50,
                    height: 20,
                    child: Center(
                      child: Text(
                        stringifyExposureMode(ExposureMode.locked),
                        style: TextStyle(
                          color: _exposureMode == ExposureMode.locked
                              ? Colors.yellow
                              : Color(0xFFF5F5F5),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            /*_exposureMode == ExposureMode.locked
                ?*/ Container(
                    width: 250,
                    child: /*SettingSlider(
                      currentValue: _currentExposureOffset,
                      values: List.generate(
                          (_maxAvailableExposureOffset +
                                      _minAvailableExposureOffset.abs()) ~/
                                  0.1 +
                              1,
                          (index) =>
                              (_minAvailableExposureOffset + (index * 0.1))),
                      onChanged: setExposureOffset,
                    ),*/ Slider(
                        activeColor: Color(0xFFF5F5F5),
                        min: _minAvailableExposureOffset,
                        max: _maxAvailableExposureOffset,
                        value: _currentExposureOffset,
                        onChanged: setExposureOffset),
                  )
                /*: Container()*/,
          ],
        );
      case 1:
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () {
                    setExposureMode(ExposureMode.locked);
                    setIsoMode(IsoMode.auto);
                    resetExposureTime();
                    //controller.setExposureTime(null);
                  },
                  child: Container(
                    width: 60,
                    height: 20,
                    child: Center(
                      child: Text(
                        stringifyIsoMode(IsoMode.auto),
                        style: TextStyle(
                          color: _isoMode == IsoMode.auto
                              ? Colors.yellow
                              : Color(0xFFF5F5F5),
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => setIsoMode(IsoMode.locked),
                  child: Container(
                    width: 50,
                    height: 20,
                    child: Center(
                      child: Text(
                        stringifyExposureMode(ExposureMode.locked),
                        style: TextStyle(
                          color: _isoMode == IsoMode.locked
                              ? Colors.yellow
                              : Color(0xFFF5F5F5),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            /*_isoMode == IsoMode.locked
                ?*/ Container(
                    width: 240,
                    child: /*SettingSlider(
                      currentValue: _currentExposureTime.toDouble(),
                      min: _minAvailableExposureTime.toDouble(),
                      max: _maxAvailableExposureTime.toDouble(),
                      values: List.generate(100, (index) => index),*/
                      /*List.generate(
                          101,
                          (index) => (_minAvailableExposureTime +
                              (index *
                                  ((_maxAvailableExposureTime -
                                          _minAvailableExposureTime) ~/
                                      (100)))))*/
                      /*onChanged: (value) => setExposureTime(
                          (_minAvailableExposureTime +
                              (value *
                                  ((_maxAvailableExposureTime -
                                          _minAvailableExposureTime) ~/
                                      (100))))),
                    ),*/ Slider(
                        activeColor: Color(0xFFF5F5F5),
                        //divisions: 100000,
                        value:
                            (_currentExposureTime - _minAvailableExposureTime) /
                                (_maxAvailableExposureTime -
                                    _minAvailableExposureTime),
                        onChanged: (value) {
                          //setExposureMode(ExposureMode.auto);
                          setExposureTime(_minAvailableExposureTime +
                              (value *
                                      (_maxAvailableExposureTime -
                                          _minAvailableExposureTime))
                                  .toInt());
                        }),
                  )
                /*: Container()*/,
          ],
        );
      case 2:
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () {
                    setExposureMode(ExposureMode.locked);
                    setIsoMode(IsoMode.auto);
                    //resetExposureTime();
                    //controller.setExposureTime(null);
                  },
                  child: Container(
                    width: 60,
                    height: 20,
                    child: Center(
                      child: Text(
                        stringifyIsoMode(IsoMode.auto),
                        style: TextStyle(
                          color: _isoMode == IsoMode.auto
                              ? Colors.yellow
                              : Color(0xFFF5F5F5),
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => setIsoMode(IsoMode.locked),
                  child: Container(
                    width: 50,
                    height: 20,
                    child: Center(
                      child: Text(
                        stringifyExposureMode(ExposureMode.locked),
                        style: TextStyle(
                          color: _isoMode == IsoMode.locked
                              ? Colors.yellow
                              : Color(0xFFF5F5F5),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            /*_isoMode == IsoMode.locked
                ? */Container(
                    width: 240,
                    child: /*SettingSlider(
                      currentValue: _currentIsoValue.toDouble(),
                      values: List.generate(
                          (_maxAvailableIsoValue + 100) ~/ 100 - 1,
                          (index) => (100 + (index * 100))),
                      onChanged: (value) => setIsoValue(value.toInt()),
                    ),*/ Slider(
                        activeColor: Color(0xFFF5F5F5),
                        divisions:
                            (_maxAvailableIsoValue - 100) ~/
                                100,
                        value: (_currentIsoValue - 100) /
                            (_maxAvailableIsoValue - 100),
                        onChanged: (value) {
                          setIsoValue(100 +
                              (value *
                                      (_maxAvailableIsoValue -
                                          100))
                                  .toInt());
                        }),
                  )
                /*: Container()*/,
          ],
        );
      case 3:
        return Slider(
            activeColor: Color(0xFFF5F5F5),
            divisions: wbValues.length - 1,
            min: 0.0,
            max: (wbValues.length - 1).toDouble(),
            value: wbValues.keys.toList().indexOf(_wbMode).toDouble(),
            onChanged: (value) {
              setWbMode(wbValues.keys.toList()[value.toInt()]);
            });
      case 4:
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: () {
                controller.setFocusPoint(null);
                setFocusMode(FocusMode.auto);
              },
              child: Container(
                width: 40,
                height: 20,
                child: Text(
                  stringifyFocusMode(FocusMode.auto),
                  style: TextStyle(
                    color: _focusMode == FocusMode.auto
                        ? Colors.yellow
                        : Color(0xFFF5F5F5),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () => setFocusMode(FocusMode.locked),
              child: Container(
                width: 40,
                height: 20,
                child: Text(
                  stringifyFocusMode(FocusMode.locked),
                  style: TextStyle(
                    color: _focusMode == FocusMode.locked
                        ? Colors.yellow
                        : Color(0xFFF5F5F5),
                  ),
                ),
              ),
            ),
          ],
        );
      default:
        return Container();
    }
  }

  String nanosecsToSecondSplit(int nanosecs) {
    var seconds = nanosecs / pow(10, 9);
    var secondSplit = 1 ~/ seconds;
    return '1/${secondSplit.toStringAsExponential(0)}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: buildTopBar(context),
      ),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            return _cameraPreviewWidget();
          } else {
            // Otherwise, display a loading indicator.
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      /*Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
              constraints: BoxConstraints.tightFor(width: double.infinity),
              child: _cameraPreviewWidget(),
              decoration: BoxDecoration(
                color: Colors.black,
              ),
            ),
          //SizedBox(height: 80),
        ],
      ),*/
      bottomNavigationBar: Container(
        height: _isSettingsShown ? 160 : 80,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _isSettingsShown
                ? Container(
                    height: 80,
                    decoration: BoxDecoration(
                      color: Color(0xFF282828).withOpacity(0.45),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 36,
                          child: buildSettings(),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () => changeSettingIndex(0),
                              child: Container(
                                width: 48,
                                height: 44,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      'Exp',
                                      style: TextStyle(
                                          fontFamily: 'PT Root UI',
                                          fontSize: 12,
                                          color: _currentSettingIndex == 0
                                              ? Colors.yellow
                                              : Color(0xF5F5F5).withOpacity(1)),
                                    ),
                                    Text(
                                      '${_currentExposureOffset >= 0 ? "+" + _currentExposureOffset.toStringAsFixed(1) : _currentExposureOffset.toStringAsFixed(1)}',
                                      style: TextStyle(
                                          fontFamily: 'Roboto',
                                          color:
                                              Color(0xF5F5F5).withOpacity(1)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () => changeSettingIndex(1),
                              child: Container(
                                width: 48,
                                height: 44,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      'Sec',
                                      style: TextStyle(
                                          fontFamily: 'PT Root UI',
                                          fontSize: 12,
                                          color: _currentSettingIndex == 1
                                              ? Colors.yellow
                                              : Color(0xF5F5F5).withOpacity(1)),
                                    ),
                                    Text(
                                      nanosecsToSecondSplit(
                                          _currentExposureTime),
                                      style: TextStyle(
                                          fontFamily: 'Roboto',
                                          color:
                                              Color(0xF5F5F5).withOpacity(1)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () => changeSettingIndex(2),
                              child: Container(
                                width: 48,
                                height: 44,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      'ISO',
                                      style: TextStyle(
                                          fontFamily: 'PT Root UI',
                                          fontSize: 12,
                                          color: _currentSettingIndex == 2
                                              ? Colors.yellow
                                              : Color(0xF5F5F5).withOpacity(1)),
                                    ),
                                    Text(
                                      '${_currentIsoValue}',
                                      style: TextStyle(
                                          fontFamily: 'Roboto',
                                          color:
                                              Color(0xF5F5F5).withOpacity(1)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () => changeSettingIndex(3),
                              child: Container(
                                width: 48,
                                height: 44,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      'WB',
                                      style: TextStyle(
                                          fontFamily: 'PT Root UI',
                                          fontSize: 12,
                                          color: _currentSettingIndex == 3
                                              ? Colors.yellow
                                              : Color(0xF5F5F5).withOpacity(1)),
                                    ),
                                    Text(
                                      stringifyWbMode(_wbMode),
                                      style: TextStyle(
                                          fontFamily: 'Roboto',
                                          color:
                                              Color(0xF5F5F5).withOpacity(1)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () => changeSettingIndex(4),
                              child: Container(
                                width: 48,
                                height: 44,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/focus.svg',
                                      color: _currentSettingIndex == 4
                                          ? Colors.yellow
                                          : Color(0xF5F5F5).withOpacity(1),
                                    ),
                                    Text(
                                      stringifyFocusMode(_focusMode),
                                      style: TextStyle(
                                          fontFamily: 'Roboto',
                                          color:
                                              Color(0xF5F5F5).withOpacity(1)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: resetSettings,
                              child: Container(
                                width: 48,
                                height: 44,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/reset.svg',
                                      width: 11.5,
                                      height: 11,
                                    ),
                                    Text(
                                      'RESET',
                                      style: TextStyle(
                                          color:
                                              Color(0xF5F5F5).withOpacity(1)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                : Container(),
            buildBottomBar(context, _isSettingsShown ? 'collapse' : 'expand'),
          ],
        ),
      ),
    );
  }

  void toggleSettings() {
    setState(() {
      //_sliderDisplay = SliderDisplay.None;
      _isSettingsShown = !_isSettingsShown;
    });
  }

  void toggleGrid() {
    setState(() {
      _isGridVisible = !_isGridVisible;
    });
  }

  void toggleHorizon() {
    _isHorizonVisible ? unsubscribeFromGiro() : subscribeToGiro();
    setState(() {
      _isHorizonVisible = !_isHorizonVisible;
    });
  }

  void subscribeToGiro() {
    _horizonLevel = 0.0;
    _gyroscopeSubscription = gyroscopeEvents.listen((GyroscopeEvent event) {
      setState(() {
        _horizonLevel += event.z / 2.65;
      });
    });
  }

  void unsubscribeFromGiro() {
    _horizonLevel = 0.0;
    _gyroscopeSubscription?.cancel();
  }

  Container buildBottomBar(BuildContext context, String arrowType) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Color(0xFF282828),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: toggleSettings,
                    child: Container(
                      width: 48,
                      height: 48,
                      child: SvgPicture.asset(
                        'assets/icons/${_isSettingsShown ? "expand" : "collapse"}_arrow.svg',
                        fit: BoxFit.none,
                        color: Color(0xFFF5F5F5),
                      ),
                    ),
                  ),
                  AnimatedBuilder(
                    animation: _iconRotationAnimation,
                    child: InkWell(
                      onTap: () {
                        toggleHorizon();
                      },
                      child: Container(
                        width: 48,
                        height: 48,
                        child: SvgPicture.asset(
                          'assets/icons/horizon.svg',
                          fit: BoxFit.none,
                          color: _isHorizonVisible
                              ? Color(0xFFFFD600)
                              : Color(0xFFF5F5F5),
                        ),
                      ),
                    ),
                    builder: (BuildContext context, Widget child) {
                      return Transform.rotate(
                        angle: _iconRotationAnimation.value,
                        child: child,
                      );
                    },
                  ),
                ],
              ),
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: Color(0xFFF5F5F5),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: FlatButton(
                    padding: EdgeInsets.zero,
                    shape: CircleBorder(),
                    onPressed: onTakePictureButtonPressed,
                    child: Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFF282828), width: 1),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  AnimatedBuilder(
                    animation: _iconRotationAnimation,
                    child: InkWell(
                      onTap: () {
                        toggleGrid();
                      },
                      child: Container(
                        width: 48,
                        height: 48,
                        child: SvgPicture.asset(
                          'assets/icons/grid.svg',
                          fit: BoxFit.none,
                          color: _isGridVisible
                              ? Color(0xFFFFD600)
                              : Color(0xFFF5F5F5),
                        ),
                      ),
                    ),
                    builder: (BuildContext context, Widget child) {
                      return Transform.rotate(
                        angle: _iconRotationAnimation.value,
                        child: child,
                      );
                    },
                  ),
                  AnimatedBuilder(
                    animation: _iconRotationAnimation,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    MainPage(selectedIndex: 2)));
                      },
                      child: Container(
                        width: 48,
                        height: 48,
                        child: Icon(
                          Icons.photo_library,
                          color: Color(0xFFF5F5F5),
                        ),
                      ),
                    ),
                    builder: (BuildContext context, Widget child) {
                      return Transform.rotate(
                        angle: _iconRotationAnimation.value,
                        child: child,
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  AppBar buildTopBar(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xFF282828),
      elevation: 0,
      brightness: Brightness.dark,
      automaticallyImplyLeading: false,
      flexibleSpace: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  AnimatedBuilder(
                    animation: _iconRotationAnimation,
                    child: InkWell(
                      onTap: toggleTorch,
                      child: Container(
                        width: 48,
                        height: 48,
                        child: getTorchIcon(),
                      ),
                    ),
                    builder: (BuildContext context, Widget child) {
                      return Transform.rotate(
                        angle: _iconRotationAnimation.value,
                        child: child,
                      );
                    },
                  ),
                ],
              ),
              InkWell(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 48,
                  height: 48,
                  child: Icon(
                    Icons.close,
                    color: Color(0xFFF5F5F5),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> toggleTorch() async {
    if (_flashMode == FlashMode.off) {
      // Turn on the flash for capture
      _flashMode = FlashMode.torch;
    } else if (_flashMode == FlashMode.always ||
        _flashMode == FlashMode.torch) {
      // Turn on the flash for capture if needed
      _flashMode = FlashMode.auto;
    } else {
      // Turn off the flash
      _flashMode = FlashMode.off;
    }

    await controller.setFlashMode(_flashMode);

    setState(() {});
  }

  Icon getTorchIcon() {
    switch (_flashMode) {
      case FlashMode.off:
        return Icon(
          Icons.flash_off,
          color: Color(0xFFF5F5F5),
        );
      case FlashMode.always:
        return Icon(
          Icons.flash_on,
          color: Color(0xFFFFD600),
        );
      case FlashMode.torch:
        return Icon(
          Icons.flash_on,
          color: Color(0xFFFFD600),
        );
      case FlashMode.auto:
        return Icon(
          Icons.flash_auto,
          color: Color(0xFFFFD600),
        );
      default:
        return Icon(
          Icons.flash_off,
          color: Color(0xFFF5F5F5),
        );
    }
  }

  /// Display the preview from the camera (or a message if the preview is not available).
  Widget _cameraPreviewWidget() {
    if (controller == null || !controller.value.isInitialized) {
      return Container();
    } else {
      return Stack(
        alignment: Alignment.center,
        children: [
          AspectRatio(
            aspectRatio: controller.value.aspectRatio,
            child: Listener(
              onPointerDown: (_) => _pointers++,
              onPointerUp: (_) => _pointers--,
              child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                return GestureDetector(
                  onScaleStart: _handleScaleStart,
                  onScaleUpdate: _handleScaleUpdate,
                  onTapDown: (details) => onViewFinderTap(details, constraints),
                  child: CameraPreview(controller),
                );
              }),
            ),
          ),
          _isGridVisible
              ? AspectRatio(
                  aspectRatio: controller.value.aspectRatio,
                  child: buildGrid(),
                )
              : Container(),
          _isHorizonVisible ? buildHorizonLevel() : Container(),
        ],
      );
    }
  }

  void _handleScaleStart(ScaleStartDetails details) {
    _baseScale = _currentScale;
  }

  Future<void> _handleScaleUpdate(ScaleUpdateDetails details) async {
    // When there are not exactly two fingers on screen don't scale
    if (_pointers != 2) {
      return;
    }

    _currentScale = (_baseScale * details.scale)
        .clamp(_minAvailableZoom, _maxAvailableZoom);

    await controller.setZoomLevel(_currentScale);
  }

  /// Display the thumbnail of the captured image or video.
  Widget _thumbnailWidget() {
    return Positioned.fill(
      child: Align(
        alignment: Alignment.centerRight,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            videoController == null && imageFile == null
                ? Container()
                : SizedBox(
                    child: (videoController == null)
                        ? Image.file(File(imageFile.path))
                        : Container(
                            child: Center(
                              child: AspectRatio(
                                  aspectRatio:
                                      videoController.value.size != null
                                          ? videoController.value.aspectRatio
                                          : 1.0,
                                  child: VideoPlayer(videoController)),
                            ),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.pink)),
                          ),
                    width: 64.0,
                    height: 64.0,
                  ),
          ],
        ),
      ),
    );
  }

  /// Display a bar with buttons to change the flash and exposure modes
  Widget _modeControlRowWidget() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.flash_on),
              color: Colors.blue,
              //onPressed: controller != null ? onFlashModeButtonPressed : null,
            ),
            IconButton(
              icon: Icon(Icons.exposure),
              color: Colors.blue,
              //onPressed: controller != null ? onExposureModeButtonPressed : null,
            ),
            IconButton(
              icon: Icon(Icons.filter_center_focus),
              color: Colors.blue,
              // onPressed: controller != null ? onFocusModeButtonPressed : null,
            ),
            IconButton(
              icon: Icon(enableAudio ? Icons.volume_up : Icons.volume_mute),
              color: Colors.blue,
              // onPressed: controller != null ? onAudioModeButtonPressed : null,
            ),
          ],
        ),
        _flashModeControlRowWidget(),
        _exposureModeControlRowWidget(),
        _focusModeControlRowWidget(),
      ],
    );
  }

  Widget _flashModeControlRowWidget() {
    return ClipRect(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
          IconButton(
            icon: Icon(Icons.flash_off),
            color: controller?.value?.flashMode == FlashMode.off
                ? Colors.orange
                : Colors.blue,
            onPressed: controller != null
                ? () => onSetFlashModeButtonPressed(FlashMode.off)
                : null,
          ),
          IconButton(
            icon: Icon(Icons.flash_auto),
            color: controller?.value?.flashMode == FlashMode.auto
                ? Colors.orange
                : Colors.blue,
            onPressed: controller != null
                ? () => onSetFlashModeButtonPressed(FlashMode.auto)
                : null,
          ),
          IconButton(
            icon: Icon(Icons.flash_on),
            color: controller?.value?.flashMode == FlashMode.always
                ? Colors.orange
                : Colors.blue,
            onPressed: controller != null
                ? () => onSetFlashModeButtonPressed(FlashMode.always)
                : null,
          ),
          IconButton(
            icon: Icon(Icons.highlight),
            color: controller?.value?.flashMode == FlashMode.torch
                ? Colors.orange
                : Colors.blue,
            onPressed: controller != null
                ? () => onSetFlashModeButtonPressed(FlashMode.torch)
                : null,
          ),
        ],
      ),
    );
  }

  Widget _exposureModeControlRowWidget() {
    final ButtonStyle styleAuto = TextButton.styleFrom(
      primary: controller?.value?.exposureMode == ExposureMode.auto
          ? Colors.orange
          : Colors.blue,
    );
    final ButtonStyle styleLocked = TextButton.styleFrom(
      primary: controller?.value?.exposureMode == ExposureMode.locked
          ? Colors.orange
          : Colors.blue,
    );

    return ClipRect(
      child: Container(
        color: Colors.grey.shade50,
        child: Column(
          children: [
            Center(
              child: Text("Exposure Mode"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: [
                TextButton(
                  child: Text('AUTO'),
                  style: styleAuto,
                  onPressed: controller != null
                      ? () => onSetExposureModeButtonPressed(ExposureMode.auto)
                      : null,
                  onLongPress: () {
                    if (controller != null) controller.setExposurePoint(null);
                    showInSnackBar('Resetting exposure point');
                  },
                ),
                TextButton(
                  child: Text('LOCKED'),
                  style: styleLocked,
                  onPressed: controller != null
                      ? () =>
                          onSetExposureModeButtonPressed(ExposureMode.locked)
                      : null,
                ),
              ],
            ),
            Center(
              child: Text("Exposure Offset"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(_minAvailableExposureOffset.toString()),
                Slider(
                  value: _currentExposureOffset,
                  min: _minAvailableExposureOffset,
                  max: _maxAvailableExposureOffset,
                  label: _currentExposureOffset.toString(),
                  onChanged:
                      _minAvailableExposureOffset == _maxAvailableExposureOffset
                          ? null
                          : setExposureOffset,
                ),
                Text(_maxAvailableExposureOffset.toString()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _focusModeControlRowWidget() {
    final ButtonStyle styleAuto = TextButton.styleFrom(
      primary: controller?.value?.focusMode == FocusMode.auto
          ? Colors.orange
          : Colors.blue,
    );
    final ButtonStyle styleLocked = TextButton.styleFrom(
      primary: controller?.value?.focusMode == FocusMode.locked
          ? Colors.orange
          : Colors.blue,
    );

    return ClipRect(
      child: Container(
        color: Colors.grey.shade50,
        child: Column(
          children: [
            Center(
              child: Text("Focus Mode"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: [
                TextButton(
                  child: Text('AUTO'),
                  style: styleAuto,
                  onPressed: controller != null
                      ? () => onSetFocusModeButtonPressed(FocusMode.auto)
                      : null,
                  onLongPress: () {
                    if (controller != null) controller.setFocusPoint(null);
                    showInSnackBar('Resetting focus point');
                  },
                ),
                TextButton(
                  child: Text('LOCKED'),
                  style: styleLocked,
                  onPressed: controller != null
                      ? () => onSetFocusModeButtonPressed(FocusMode.locked)
                      : null,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Display the control bar with buttons to take pictures and record videos.
  Widget _captureControlRowWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.camera_alt),
          color: Colors.blue,
          onPressed: controller != null &&
                  controller.value.isInitialized &&
                  !controller.value.isRecordingVideo
              ? onTakePictureButtonPressed
              : null,
        ),
        IconButton(
          icon: const Icon(Icons.videocam),
          color: Colors.blue,
          onPressed: controller != null &&
                  controller.value.isInitialized &&
                  !controller.value.isRecordingVideo
              ? onVideoRecordButtonPressed
              : null,
        ),
        IconButton(
          icon: controller != null && controller.value.isRecordingPaused
              ? Icon(Icons.play_arrow)
              : Icon(Icons.pause),
          color: Colors.blue,
          onPressed: controller != null &&
                  controller.value.isInitialized &&
                  controller.value.isRecordingVideo
              ? (controller != null && controller.value.isRecordingPaused
                  ? onResumeButtonPressed
                  : onPauseButtonPressed)
              : null,
        ),
        IconButton(
          icon: const Icon(Icons.stop),
          color: Colors.red,
          onPressed: controller != null &&
                  controller.value.isInitialized &&
                  controller.value.isRecordingVideo
              ? onStopButtonPressed
              : null,
        )
      ],
    );
  }

  /// Display a row of toggle to select the camera (or a message if no camera is available).
  Widget _cameraTogglesRowWidget() {
    final List<Widget> toggles = <Widget>[];

    if (CameraConfig.cameras.isEmpty) {
      return const Text('No camera found');
    } else {
      for (CameraDescription cameraDescription in CameraConfig.cameras) {
        toggles.add(
          SizedBox(
            width: 90.0,
            child: RadioListTile<CameraDescription>(
              title: Icon(getCameraLensIcon(cameraDescription.lensDirection)),
              groupValue: controller?.description,
              value: cameraDescription,
              onChanged: controller != null && controller.value.isRecordingVideo
                  ? null
                  : onNewCameraSelected,
            ),
          ),
        );
      }
    }

    return Row(children: toggles);
  }

  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  void showInSnackBar(String message) {
    // ignore: deprecated_member_use
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message)));
  }

  void onViewFinderTap(TapDownDetails details, BoxConstraints constraints) {
    final offset = Offset(
      details.localPosition.dx / constraints.maxWidth,
      details.localPosition.dy / constraints.maxHeight,
    );
    controller.setExposurePoint(offset);
    controller.setFocusPoint(offset);
  }

  void onNewCameraSelected(CameraDescription cameraDescription) async {
    if (controller != null) {
      await controller.dispose();
    }
    controller = CameraController(
      cameraDescription,
      ResolutionPreset.veryHigh,
      enableAudio: enableAudio,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    // If the controller is updated then update the UI.
    controller.addListener(() {
      if (mounted) setState(() {});
      if (controller.value.hasError) {
        showInSnackBar('Camera error ${controller.value.errorDescription}');
      }
    });

    try {
      _initializeControllerFuture = controller.initialize();
      await _initializeControllerFuture;
      _minAvailableExposureOffset = await controller.getMinExposureOffset();
      _maxAvailableExposureOffset = await controller.getMaxExposureOffset();
      _minAvailableExposureTime = await controller.getMinExposureTime();
      _maxAvailableExposureTime = await controller.getMaxExposureTime();
      _minAvailableIsoValue = await controller.getMinIsoValue();
      _maxAvailableIsoValue = await controller.getMaxIsoValue();
      _currentExposureTime =
          (_maxAvailableExposureTime - _minAvailableExposureTime) ~/ 2 +
              _minAvailableExposureTime;
      _maxAvailableZoom = await controller.getMaxZoomLevel();
      _minAvailableZoom = await controller.getMinZoomLevel();
    } on CameraException catch (e) {
      _showCameraException(e);
    }

    if (mounted) {
      setState(() {});
    }
  }

  void onTakePictureButtonPressed() {
    takePicture().then((XFile file) {
      if (mounted) {
        setState(() {
          imageFile = file;
          videoController?.dispose();
          videoController = null;
        });
        if (file != null) {
          var state = context.read<AuthCubit>().state;
          if (state is AuthSignedIn)
            ApiPhotoRepository().addPhoto(state.token, file.path).then((_) {
              context.read<PhotoCubit>().getPhotos(state.token);
            });
        }
        ;
      }
    });
  }

  /*void onFlashModeButtonPressed() {
    if (_flashModeControlRowAnimationController.value == 1) {
      _flashModeControlRowAnimationController.reverse();
    } else {
      _flashModeControlRowAnimationController.forward();
      _exposureModeControlRowAnimationController.reverse();
      _focusModeControlRowAnimationController.reverse();
    }
  }

  void onExposureModeButtonPressed() {
    if (_exposureModeControlRowAnimationController.value == 1) {
      _exposureModeControlRowAnimationController.reverse();
    } else {
      _exposureModeControlRowAnimationController.forward();
      _flashModeControlRowAnimationController.reverse();
      _focusModeControlRowAnimationController.reverse();
    }
  }

  void onFocusModeButtonPressed() {
    if (_focusModeControlRowAnimationController.value == 1) {
      _focusModeControlRowAnimationController.reverse();
    } else {
      _focusModeControlRowAnimationController.forward();
      _flashModeControlRowAnimationController.reverse();
      _exposureModeControlRowAnimationController.reverse();
    }
  }

  void onAudioModeButtonPressed() {
    enableAudio = !enableAudio;
    if (controller != null) {
      onNewCameraSelected(controller.description);
    }
  }*/

  void onSetFlashModeButtonPressed(FlashMode mode) {
    setFlashMode(mode).then((_) {
      if (mounted) setState(() {});
      showInSnackBar('Flash mode set to ${mode.toString().split('.').last}');
    });
  }

  void onSetExposureModeButtonPressed(ExposureMode mode) {
    setExposureMode(mode).then((_) {
      if (mounted) setState(() {});
      showInSnackBar('Exposure mode set to ${mode.toString().split('.').last}');
    });
  }

  void onSetFocusModeButtonPressed(FocusMode mode) {
    setFocusMode(mode).then((_) {
      if (mounted) setState(() {});
      showInSnackBar('Focus mode set to ${mode.toString().split('.').last}');
    });
  }

  void onVideoRecordButtonPressed() {
    startVideoRecording().then((_) {
      if (mounted) setState(() {});
    });
  }

  void onStopButtonPressed() {
    stopVideoRecording().then((file) {
      if (mounted) setState(() {});
      if (file != null) {
        showInSnackBar('Video recorded to ${file.path}');
        videoFile = file;
        _startVideoPlayer();
      }
    });
  }

  void onPauseButtonPressed() {
    pauseVideoRecording().then((_) {
      if (mounted) setState(() {});
      showInSnackBar('Video recording paused');
    });
  }

  void onResumeButtonPressed() {
    resumeVideoRecording().then((_) {
      if (mounted) setState(() {});
      showInSnackBar('Video recording resumed');
    });
  }

  Future<void> startVideoRecording() async {
    if (!controller.value.isInitialized) {
      showInSnackBar('Error: select a camera first.');
      return;
    }

    if (controller.value.isRecordingVideo) {
      // A recording is already started, do nothing.
      return;
    }

    try {
      await controller.startVideoRecording();
    } on CameraException catch (e) {
      _showCameraException(e);
      return;
    }
  }

  Future<XFile> stopVideoRecording() async {
    if (!controller.value.isRecordingVideo) {
      return null;
    }

    try {
      return controller.stopVideoRecording();
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }
  }

  Future<void> pauseVideoRecording() async {
    if (!controller.value.isRecordingVideo) {
      return null;
    }

    try {
      await controller.pauseVideoRecording();
    } on CameraException catch (e) {
      _showCameraException(e);
      rethrow;
    }
  }

  Future<void> resumeVideoRecording() async {
    if (!controller.value.isRecordingVideo) {
      return null;
    }

    try {
      await controller.resumeVideoRecording();
    } on CameraException catch (e) {
      _showCameraException(e);
      rethrow;
    }
  }

  Future<void> setFlashMode(FlashMode mode) async {
    setState(() {
      _flashMode = mode;
    });
    try {
      await controller.setFlashMode(mode);
    } on CameraException catch (e) {
      _showCameraException(e);
      rethrow;
    }
  }

  Future<void> setExposureMode(ExposureMode mode) async {
    setState(() {
      _exposureMode = mode;
    });
    try {
      await controller.setExposureMode(mode);
    } on CameraException catch (e) {
      _showCameraException(e);
      rethrow;
    }
  }

  Future<void> setIsoMode(IsoMode mode) async {
    setState(() {
      _isoMode = mode;
    });
    try {
      await controller.setIsoMode(mode);
    } on CameraException catch (e) {
      _showCameraException(e);
      rethrow;
    }
  }

  Future<void> setExposureOffset(double offset) async {
    setState(() {
      _currentExposureOffset = offset;
    });
    try {
      offset = await controller.setExposureOffset(offset);
    } on CameraException catch (e) {
      _showCameraException(e);
      rethrow;
    }
  }

  Future<void> setExposureTime(int nanosecs) async {
    setState(() {
      _currentExposureTime = nanosecs;
    });
    try {
      nanosecs = await controller.setExposureTime(nanosecs);
    } on CameraException catch (e) {
      _showCameraException(e);
      rethrow;
    }
  }

  Future<void> setIsoValue(int sensetivity) async {
    setState(() {
      _currentIsoValue = sensetivity;
    });
    try {
      sensetivity = await controller.setIsoValue(sensetivity);
    } on CameraException catch (e) {
      _showCameraException(e);
      rethrow;
    }
  }

  Future<void> setFocusMode(FocusMode mode) async {
    setState(() {
      _focusMode = mode;
    });
    try {
      await controller.setFocusMode(mode);
    } on CameraException catch (e) {
      _showCameraException(e);
      rethrow;
    }
  }

  Future<void> setWbMode(WbMode mode) async {
    setState(() {
      _wbMode = mode;
    });
    try {
      await controller.setWbMode(mode);
    } on CameraException catch (e) {
      _showCameraException(e);
      rethrow;
    }
  }

  Future<void> _startVideoPlayer() async {
    final VideoPlayerController vController =
        VideoPlayerController.file(File(videoFile.path));
    videoPlayerListener = () {
      if (videoController != null && videoController.value.size != null) {
        // Refreshing the state to update video player with the correct ratio.
        if (mounted) setState(() {});
        videoController.removeListener(videoPlayerListener);
      }
    };
    vController.addListener(videoPlayerListener);
    await vController.setLooping(true);
    await vController.initialize();
    await videoController?.dispose();
    if (mounted) {
      setState(() {
        imageFile = null;
        videoController = vController;
      });
    }
    await vController.play();
  }

  Future<XFile> takePicture() async {
    if (!controller.value.isInitialized) {
      showInSnackBar('Error: select a camera first.');
      return null;
    }

    if (controller.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }

    try {
      XFile file = await controller.takePicture();
      return file;
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }
  }

  void _showCameraException(CameraException e) {
    logError(e.code, e.description);
    showInSnackBar('Error: ${e.code}\n${e.description}');
  }
}
