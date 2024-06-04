import 'package:auto_size_text/auto_size_text.dart';
import 'package:edge_detection/edge_detection.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
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
  String imagePath = "not opened";
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  void menuUpload() async {
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
    imagePath = join((await getApplicationSupportDirectory()).path,
        "${(DateTime.now().millisecondsSinceEpoch / 1000).round()}.jpeg");
    // print(imagePath);
    // Use below code for live camera detection with option to select from gallery in the camera feed.

    try {
      //Make sure to await the call to detectEdge.
      cameraOpened = await EdgeDetection.detectEdge(
        imagePath,
        canUseGallery: false,
        androidScanTitle: '스캔하기', // use custom localizations for android
        androidCropTitle: '잘라내기',
        androidCropBlackWhiteTitle: 'Black White',
        androidCropReset: '재설정',
      );
    } catch (e) {
      print(e);
    }
    // print(cameraOpened);
    setState(() {
      _btnController.success();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("계절밥상 식단표 업로드"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/images/camera_access.png"),
            const Gap(30),
            const AutoSizeText(
              "계절밥상 식단표를 촬영해주세요.",
              minFontSize: 25,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const AutoSizeText(
              "이미지 업로드를 위하여 카메라 권한을 허용해주세요!",
              minFontSize: 18,
              style: TextStyle(fontWeight: FontWeight.normal),
            ),
            const Gap(130),
            // Text(imagePath),
            RoundedLoadingButton(
              controller: _btnController,
              onPressed: menuUpload,
              child: const Text('업로드 시작 !',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            )
          ],
        ),
      ),
    );
  }
}
