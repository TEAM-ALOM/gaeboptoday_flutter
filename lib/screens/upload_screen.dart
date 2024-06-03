import 'package:edge_detection/edge_detection.dart';
import 'package:flutter/material.dart';
import 'package:gaeboptoday_flutter/screens/camera_screen.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  bool cameraOpened = false;
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  void _doSomething() async {
    // Check permissions and request its
    bool isCameraGranted = await Permission.camera.request().isGranted;
    if (!isCameraGranted) {
      isCameraGranted =
          await Permission.camera.request() == PermissionStatus.granted;
    }

    if (!isCameraGranted) {
      // Have not permission to camera
      return;
    }

// Generate filepath for saving
    String imagePath = join((await getApplicationSupportDirectory()).path,
        "${(DateTime.now().millisecondsSinceEpoch / 1000).round()}.jpeg");

// Use below code for live camera detection with option to select from gallery in the camera feed.

    try {
      //Make sure to await the call to detectEdge.
      bool success = await EdgeDetection.detectEdge(
        imagePath,
        canUseGallery: true,
        androidScanTitle: 'Scanning', // use custom localizations for android
        androidCropTitle: 'Crop',
        androidCropBlackWhiteTitle: 'Black White',
        androidCropReset: 'Reset',
      );
    } catch (e) {
      print(e);
    }

// Use below code for selecting directly from the gallery.

    try {
      //Make sure to await the call to detectEdgeFromGallery.
      bool success = await EdgeDetection.detectEdgeFromGallery(
        imagePath,
        androidCropTitle: 'Crop', // use custom localizations for android
        androidCropBlackWhiteTitle: 'Black White',
        androidCropReset: 'Reset',
      );
    } catch (e) {
      print(e);
    }
    setState(() {
      _btnController.success();
      // cameraOpened = true;
    });

    // print(cameraOpened);
    // Timer(const Duration(seconds: 3), () {
    //   _btnController.success();
    // });
  }
// Use the `FlutterDocScanner` class to start the document scanning process.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            cameraOpened
                ? Expanded(
                    child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    // child: CameraScreen(cameras: widget.cameras),
                    // child: FlutterDocScanner().getScanDocuments(),
                  ))
                : RoundedLoadingButton(
                    controller: _btnController,
                    onPressed: _doSomething,
                    child: const Text('Tap me!',
                        style: TextStyle(color: Colors.white)),
                  )
          ],
        ),
      ),
    );
  }
}
