import 'package:camera/camera.dart';

class CameraConfig {
  static List<CameraDescription> cameras;

  Future<void> init() async {
    cameras = await availableCameras();
  }
}