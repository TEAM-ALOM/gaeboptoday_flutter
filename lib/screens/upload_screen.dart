import 'dart:async';
import 'dart:ui' as ui;

import 'dart:io';
import 'dart:typed_data';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:edge_detection/edge_detection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/painting.dart';
import 'package:http_parser/http_parser.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:gaeboptoday_flutter/screens/menu_data_confirm_screen.dart';
import 'package:gap/gap.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  bool cameraOpened = false, errorOccured = false;
  late int errorCode;
  late String errorMessage, errorString;
  String imagePath = "NOT OPENED";
  double percent = 0;
  late File menuImage;
  final dio = Dio();
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
    menuImage = File.fromUri(Uri.parse(imagePath));
    try {
      //Make sure to await the call to detectEdge.
      cameraOpened = await EdgeDetection.detectEdge(
        imagePath,
        canUseGallery: true, //TODO: make false again
        androidScanTitle: '스캔하기', // use custom localizations for android
        androidCropTitle: '잘라내기',
        androidCropBlackWhiteTitle: 'Black White',
        androidCropReset: '재설정',
      );
    } catch (e) {
      print(e);
    }
    if (cameraOpened) {
      setState(() {});
      // Uint8List bytes = menuImage.readAsBytesSync();
      String fileName = menuImage.path.split('/').last;
      FormData formData = FormData.fromMap({
        "image": await MultipartFile.fromFile(imagePath,
            filename: fileName, contentType: MediaType('image', 'jpeg')),
      });
      dio.options.contentType = 'multipart/form-data';
      // dio.options.maxRedirects.isFinite;
      try {
        final response = await dio.post(
          'http://52.79.88.147:3000/api/menu/upload',
          data: formData,
          onSendProgress: (int sent, int total) {
            setState(() {
              percent = sent / total;
            });
            // print('$sent $total');
          },
        );
        // // TODO: SAVE CROPP  ED IMAGE DISABLE
        // ImageGallerySaver.saveImage(bytes);
        // print(response);
        setState(() {
          //btn reset when shoot canceled

          // print(result);
          Timer(const Duration(milliseconds: 300), () {
            _btnController.success();
          });
          Timer(const Duration(seconds: 2), () {
            Navigator.of(super.context).pushReplacement(MaterialPageRoute(
                builder: (context) => MenuDataConfirmScreen(
                      menuJsonData: response.data,
                    )));
          });
        });
      } on DioException catch (e) {
        setState(() {
          _btnController.error();

          Timer(const Duration(seconds: 1), () {
            _btnController.reset();
            setState(() {
              errorOccured = true;
              cameraOpened = false;
            });
          });
        });
        // The request was made and the server responded with a status code
        // that falls out of the range of 2xx and is also not 304.
        if (e.response != null) {
          print(e.response!.data);
          print(e.response!.headers);
          errorCode = e.response!.statusCode!;
          errorMessage = e.response!.statusMessage!;
          errorString = e.response!.data['message'];
          print(e.response!.requestOptions);
        } else {
          // Something happened in setting up or sending the request that triggered an Error
          print(e.requestOptions);
          print(e.message);
        }
      }
    } else {
      setState(() {
        _btnController.reset();
      });
    }
    // print(cameraOpened);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "계절밥상 식단표 업로드",
          style: TextStyle(fontWeight: ui.FontWeight.bold, fontSize: 18),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: RoundedLoadingButton(
          successColor: Colors.blueAccent,
          color: Colors.blueAccent,
          controller: _btnController,
          onPressed: menuUpload,
          child: const Text('업로드 시작 !',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              )),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            cameraOpened
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.file(
                      menuImage,
                      height: 350,
                    ),
                  )
                : Image.asset("assets/images/camera_access.png"),
            const Gap(30),
            //Text
            AutoSizeText(
              cameraOpened
                  ? "이미지를 읽는 중입니다."
                  : (errorOccured
                      ? "❌ 읽는 중 에러가 발생하였습니다. ❌"
                      : "계절밥상 식단표를 촬영해주세요."),
              minFontSize: 20,
              maxLines: 1,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            AutoSizeText(
              cameraOpened
                  ? "잠시만 기다려주세요!"
                  : errorOccured
                      ? "계절밥상 식단표를 다시 촬영해주세요!"
                      : "이미지 업로드를 위하여 카메라 권한을 허용해주세요!",
              minFontSize: 13,
              maxLines: 1,
              style: const TextStyle(fontWeight: FontWeight.normal),
            ),
            cameraOpened
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Gap(20),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: LinearPercentIndicator(
                          // width: MediaQuery.of(context).devicePixelRatio,
                          animation: true,
                          lineHeight: 20.0,
                          // animationDuration: 2000,
                          percent: percent,
                          center: Text(
                            "${(percent * 100).toInt().toString()}%",
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: ui.FontWeight.bold,
                            ),
                          ),
                          barRadius: const ui.Radius.circular(20),
                          progressColor: Colors.blueAccent,
                        ),
                      ),
                      const Gap(90),
                    ],
                  )
                : errorOccured
                    ? Column(
                        children: [
                          const Gap(75),
                          Container(
                            decoration: const BoxDecoration(
                                // color: Colors.orange,
                                shape: BoxShape.rectangle,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(0))),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: AutoSizeText(
                                "ERROR $errorCode : $errorMessage (\"$errorString\")",
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: ui.FontWeight.w300,
                                ),
                                minFontSize: 10,
                                maxLines: 1,
                              ),
                            ),
                          ),
                          const Gap(5),
                        ],
                      )
                    : const Gap(0),
            // Text(imagePath),
          ],
        ),
      ),
    );
  }
}
