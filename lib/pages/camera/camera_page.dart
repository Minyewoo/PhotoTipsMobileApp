import 'dart:async';
import 'dart:io';
import 'dart:math' show pi;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:native_device_orientation/native_device_orientation.dart';
import 'package:photo_tips/camera_config.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'package:photo_tips/cubit/auth_cubit.dart';
import 'package:photo_tips/cubit/photo_cubit.dart';
import 'package:photo_tips/cubit/user_cubit.dart';
import 'package:photo_tips/data/repositories/photo_repository.dart';
import 'package:photo_tips/data/repositories/user_repository.dart';
import 'package:photo_tips/pages/camera/components/bottom_bar.dart';
import 'package:photo_tips/pages/galery/galery_page.dart';
import 'package:photo_tips/screen_config.dart';
import 'package:sensors/sensors.dart';

class CameraPage extends StatefulWidget {
  static String routeName = "/camera";
  final CameraDescription camera;

  CameraPage({Key key, this.camera}) : super(key: key);
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  StreamSubscription<GyroscopeEvent> _gyroscopeSubscription;
  AnimationController _animationController;
  Tween<double> _tween;
  Animation<double> _animation;
  CameraController _cameraController;
  Future<void> _initializeControllerFuture;
  Future<void> _initializeExpValuesFuture;
  Future<void> _initializeIsoValuesFuture;
  Future<void> _initializeManualModeFuture;
  bool isGridVisible;
  bool isHorizonVisible;
  bool isRAWEnabled;
  FlashMode _flashMode;
  FocusMode _focusMode;
  ExposureMode _exposureMode;
  WbMode _wbMode;
  IsoMode _isoMode;
  double _exposureOffset;
  int _isoValue;
  double _rotation;
  double _horizonLevel;
  List<dynamic> expValues;
  List<dynamic> secValues;
  List<dynamic> isoValues;
  Map<String, dynamic> focusValues = {
    'AUTO': FocusMode.auto,
    'USER': FocusMode.locked
  };
  Map<String, dynamic> wbValues = {
    'AUTO': WbMode.auto,
    '2300K': WbMode.incandescent,
    '4000K': WbMode.fluorescent,
    '4500K': WbMode.warm_fluorescent,
    '5200K': WbMode.daylight,
    '6500K': WbMode.cloudy_daylight,
    '7000K': WbMode.twilight,
    '8000K': WbMode.shade
  };
  double _minAvailableZoom;
  double _maxAvailableZoom;
  double _currentScale = 1.0;
  double _baseScale = 1.0;

  // Counting pointers (number of user fingers on screen)
  int _pointers = 0;

  StreamSubscription<NativeDeviceOrientation> _orientationSubscribtion;

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

    await _cameraController.setZoomLevel(_currentScale);
  }

  void onViewFinderTap(TapDownDetails details, BoxConstraints constraints) {
    final offset = Offset(
      details.localPosition.dx / constraints.maxWidth,
      details.localPosition.dy / constraints.maxHeight,
    );
    _cameraController.setExposurePoint(offset);
    _cameraController.setFocusPoint(offset);
  }

  @override
  void initState() {
    _rotation = 0.0;
    _horizonLevel = 0.0;
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500))
          ..value = 0.5;
    _tween = Tween(begin: -pi / 2.0, end: pi / 2.0);
    _animation = _tween.animate(_animationController)
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

    super.initState();
    WidgetsBinding.instance.addObserver(this);

    isGridVisible = false;
    isHorizonVisible = false;
    isRAWEnabled = false;
    _flashMode = FlashMode.off;
    _exposureMode = ExposureMode.auto;
    _wbMode = WbMode.auto;
    _isoMode = IsoMode.auto;
    _exposureOffset = 0.0;
    _isoValue = 100;
    // To display the current output from the Camera,
    // create a CameraController.
    _cameraController = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera ?? CameraConfig.cameras.first,
      // Define the resolution to use.
      ResolutionPreset.veryHigh,
      enableAudio: false,
    );
    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _cameraController.initialize();
    //_initializeControllerFuture.then((_) => onNewCameraSelected(_cameraController.description));

    //_initializeExpValuesFuture = initExpValues();
    //_initializeIsoValuesFuture = initIsoValues();
    _initializeManualModeFuture = initManualMode();
    //wbValues = WbMode.values.map((value) => serializeWbMode(value)).toList();
  }

  Future<void> initExpValues() async {
    await _initializeControllerFuture;
    double maxExp = await _cameraController.getMaxExposureOffset();
    double minExp = await _cameraController.getMinExposureOffset();
    expValues = [
      'AUTO',
      ...List.generate((maxExp + minExp.abs()) ~/ 0.1 + 1,
          (index) => (minExp + (index * 0.1)).toStringAsFixed(1))
    ];
  }

  Future<void> initSecValues() async {
    await _initializeControllerFuture;
    int _minAvailableExposureTime =
        await _cameraController.getMinExposureTime();
    int _maxAvailableExposureTime =
        await _cameraController.getMaxExposureTime();
    var step = (_maxAvailableExposureTime - _minAvailableExposureTime) ~/ (100);
    secValues = [
      'AUTO',
      ...List.generate(101,
          (index) => (_minAvailableExposureTime + (index * step)).toString())
    ];
    print(secValues);
  }

  Future<void> initIsoValues() async {
    await _initializeControllerFuture;
    int maxIso = await _cameraController.getMaxIsoValue();
    //int minIso = await _cameraController.getMinIsoValue();
    isoValues = [
      'AUTO',
      ...List.generate(
          (maxIso + 100) ~/ 100 - 1, (index) => (100 + (index * 100)))
    ];
  }

  Future<void> initManualMode() async {
    await _initializeControllerFuture;
    await initExpValues();
    await initSecValues();
    await initIsoValues();
    _maxAvailableZoom = await _cameraController.getMaxZoomLevel();
    _minAvailableZoom = await _cameraController.getMinZoomLevel();
    _cameraController.setExposureMode(ExposureMode.auto);
    _cameraController.setFocusMode(FocusMode.auto);
  }

  String serializeWbMode(WbMode exposureMode) {
    switch (exposureMode) {
      case WbMode.auto:
        return 'auto';
      case WbMode.incandescent:
        return 'incandescent';
      case WbMode.fluorescent:
        return 'fluorescent';
      case WbMode.warm_fluorescent:
        return 'warm_fluorescent';
      case WbMode.daylight:
        return 'daylight';
      case WbMode.cloudy_daylight:
        return 'cloudy_daylight';
      case WbMode.twilight:
        return 'twilight';
      case WbMode.shade:
        return 'shade';
      default:
        throw ArgumentError('Unknown WbMode value');
    }
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
    _animationController.animateTo(
      progress,
      curve: Curves.easeInOut,
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // App state changed before we got the chance to initialize.
    if (_cameraController == null || !_cameraController.value.isInitialized) {
      return;
    }
    if (state == AppLifecycleState.inactive) {
      _cameraController?.dispose();
    } else if (state == AppLifecycleState.resumed) {
      if (_cameraController != null) {
        onNewCameraSelected(_cameraController.description);
      }
    }
  }

  void onNewCameraSelected(CameraDescription cameraDescription) async {
    if (_cameraController != null) {
      await _cameraController.dispose();
    }
    _cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.veryHigh,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    // If the controller is updated then update the UI.
    _cameraController.addListener(() {
      if (mounted) setState(() {});
      if (_cameraController.value.hasError) {
        print('Camera error ${_cameraController.value.errorDescription}');
      }
    });

    try {
      await _cameraController.initialize();
      //_minAvailableExposureOffset = await _cameraController.getMinExposureOffset();
      //_maxAvailableExposureOffset = await _cameraController.getMaxExposureOffset();
      _maxAvailableZoom = await _cameraController.getMaxZoomLevel();
      _minAvailableZoom = await _cameraController.getMinZoomLevel();
    } on CameraException catch (e) {
      print(e.description);
      //_showCameraException(e);
    }

    if (mounted) {
      setState(() {});
    }
  }

  /*void onNewCameraSelected(CameraDescription cameraDescription) async {
    if (_cameraController != null) {
      await _cameraController.dispose();
    }
    _cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.veryHigh,
      enableAudio: false,
    );

    // If the controller is updated then update the UI.
    _cameraController.addListener(() {
      if (mounted) setState(() {});
      if (_cameraController.value.hasError) {
        //showInSnackBar('Camera error ${controller.value.errorDescription}');
      }
    });

    try {
      await _cameraController.initialize();
    } on CameraException catch (e) {
      //_showCameraException(e);
    }

    if (mounted) {
      setState(() {});
    }
  }*/

  @override
  void dispose() {
    _orientationSubscribtion?.cancel();
    unsubscribeFromGiro();
    // Dispose of the controller when the widget is disposed.
    WidgetsBinding.instance.removeObserver(this);
    _cameraController.dispose();
    super.dispose();
  }

  void toggleGrid() {
    setState(() {
      isGridVisible = !isGridVisible;
    });
  }

  void toggleHorizon() {
    isHorizonVisible ? unsubscribeFromGiro() : subscribeToGiro();
    setState(() {
      isHorizonVisible = !isHorizonVisible;
    });
  }

  void toggleRAW() {
    setState(() {
      isRAWEnabled = !isRAWEnabled;
    });
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

    await _cameraController.setFlashMode(_flashMode);

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

  Future<void> setExposure(dynamic value) async {
    if (value == 'AUTO') {
      await _cameraController.setExposureOffset(0.0);
      await _cameraController.setExposureMode(ExposureMode.auto);
    } else {
      //await _cameraController.setExposureMode(ExposureMode.locked);
      await _cameraController.setExposureOffset(double.parse(value));
    }
  }

  Future<void> setExposureTime(dynamic value) async {
    if (value == 'AUTO') {
      //await _cameraController.setExposureTime(100);
      await _cameraController.setExposureMode(ExposureMode.auto);
    } else {
      //await _cameraController.setExposureMode(ExposureMode.locked);
      //print(value);
      await _cameraController.setExposureMode(ExposureMode.locked);
      await _cameraController.setExposureTime(int.parse(value));
    }
  }

  Future<void> setIso(dynamic value) async {
    if (value == 'AUTO') {
      await _cameraController.setIsoMode(IsoMode.auto);
      //await _cameraController.setExposureMode(ExposureMode.auto);
    } else {
      //await _cameraController.setExposureMode(ExposureMode.locked);
      await _cameraController.setIsoMode(IsoMode.locked);
      await _cameraController.setIsoValue(value);
    }
  }

  Future<void> setWb(dynamic value) async {
    if (value == 'AUTO') {
      await _cameraController.setWbMode(WbMode.auto);
      //await _cameraController.setExposureMode(ExposureMode.auto);
    } else {
      //await _cameraController.setExposureMode(ExposureMode.locked);
      //await _cameraController.setIsoMode(IsoMode.locked);
      await _cameraController.setWbMode(wbValues[value]);
    }
  }

  Future<void> setFocusMode(dynamic value) async {
    await _cameraController.setFocusMode(focusValues[value]);
  }

  Future<XFile> takePhoto() async {
    if (!_cameraController.value.isInitialized) {
      return null;
    }

    if (_cameraController.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }

    try {
      //_cameraController.setFocusMode(FocusMode.locked);
      //_cameraController.setExposureMode(ExposureMode.locked)
      XFile file = await _cameraController.takePicture();
      return file;
    } on CameraException catch (e) {
      return null;
    }
  }

  void onTakePictureButtonPressed() async {
    var file = await takePhoto();
    var state = context.read<AuthCubit>().state;
    if (file != null && state is AuthSignedIn)
      ApiPhotoRepository().addPhoto(state.token, file.path).then((_) {
        context.read<PhotoCubit>().getPhotos(state.token);
      });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return Scaffold(
      backgroundColor: Color(0xFF282828),
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: buildTopBar(context),
      ),
      // Wait until the controller is initialized before displaying the
      // camera preview. Use a FutureBuilder to display a loading spinner
      // until the controller has finished initializing.
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            return Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  constraints: BoxConstraints.tightFor(width: double.infinity),
                  //width: double.infinity,
                  //height: MediaQuery.of(context).size.height - 80 -68-80 -30,
                  child: _cameraController != null
                      ? AspectRatio(
                          aspectRatio: _cameraController.value.aspectRatio,
                          child: Listener(
                            onPointerDown: (_) => _pointers++,
                            onPointerUp: (_) => _pointers--,
                            child: LayoutBuilder(
                              builder: (BuildContext context,
                                      BoxConstraints constraints) =>
                                  GestureDetector(
                                onScaleStart: _handleScaleStart,
                                onScaleUpdate: _handleScaleUpdate,
                                onTapDown: (details) =>
                                    onViewFinderTap(details, constraints),
                                child: CameraPreview(_cameraController),
                              ),
                            ),
                          ),
                        )
                      : Container(),
                ),
                isGridVisible
                    ? Container(
                        child: buildGrid(),
                        //height: MediaQuery.of(context).size.height - 80 - 70,
                      )
                    : Container(),
                isHorizonVisible ? buildHorizonLevel() : Container(),
              ],
            );
          } else {
            // Otherwise, display a loading indicator.
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      bottomNavigationBar: FutureBuilder<void>(
        future: _initializeManualModeFuture,
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.done
                ? BottomBar(
                    animation: _animation,
                    //isHorizonVisible: isHorizonVisible,
                    //isGridVisible: isGridVisible,
                    toggleHorizon: toggleHorizon,
                    toggleGrid: toggleGrid,
                    takePhoto: onTakePictureButtonPressed,
                    setExposure: setExposure,
                    setExposureTime: setExposureTime,
                    setIso: setIso,
                    setWhiteBalance: setWb,
                    setFocus: setFocusMode,
                    expValues: expValues,
                    secValues: secValues,
                    isoValues: isoValues,
                    wbValues: wbValues.keys.toList(),
                    focusValues: ['AUTO', 'USER'],
                  )
                : Container(),
      ),
    );
  }

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
                    animation: _animation,
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
                        angle: _animation.value,
                        child: child,
                      );
                    },
                  ),
                  /*AnimatedBuilder(
                    animation: _animation,
                    child: InkWell(
                      onTap: toggleRAW,
                      child: Container(
                        width: 48,
                        height: 48,
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 8.5, vertical: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(1),
                            color: isRAWEnabled
                                ? Color(0xFFFFD600)
                                : Color(0xFFF5F5F5),
                          ),
                          child: Center(
                            child: Text(
                              'RAW',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 12,
                                letterSpacing: 0.4,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF282828),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    builder: (BuildContext context, Widget child) {
                      return Transform.rotate(
                        angle: _animation.value,
                        child: child,
                      );
                    },
                  ),*/
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
}

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({Key key, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Результат')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Center(child: Image.file(File(imagePath))),
    );
  }
}
