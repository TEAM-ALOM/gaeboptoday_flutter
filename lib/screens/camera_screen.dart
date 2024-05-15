import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

/// CameraScreen is the Main Application.
class CameraScreen extends StatefulWidget {
  final List<CameraDescription> cameras;

  /// Default Constructor
  const CameraScreen({super.key, required this.cameras});

  @override
  State<CameraScreen> createState() => CameraScreenState();
}

class CameraScreenState extends State<CameraScreen> {
  // 카메라 컨트롤러 인스턴스 생성
  late CameraController controller;

  @override
  void initState() {
    super.initState();
    // 카메라 컨트롤러 초기화
    // _cameras[0] : 사용 가능한 카메라
    controller = CameraController(widget.cameras[0], ResolutionPreset.max,
        enableAudio: false);

    controller.initialize().then((_) {
      // 카메라가 작동되지 않을 경우
      if (!mounted) {
        return;
      }
      // 카메라가 작동될 경우
      setState(() {
        // 코드 작성
      });
    })
        // 카메라 오류 시
        .catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            print("CameraController Error : CameraAccessDenied");
            // Handle access errors here.
            break;
          default:
            print("CameraController Error");
            // Handle other errors here.
            break;
        }
      }
    });
  }

  // 사진을 찍는 함수
  Future<void> _takePicture() async {
    if (!controller.value.isInitialized) {
      return;
    }

    try {
      // 사진 촬영
      final XFile file = await controller.takePicture();

      // import 'dart:io';
      // 사진을 저장할 경로 : 기본경로(storage/emulated/0/)
      Directory directory = Directory('storage/emulated/0/DCIM/MyImages');

      // 지정한 경로에 디렉토리를 생성하는 코드
      // .create : 디렉토리 생성    recursive : true - 존재하지 않는 디렉토리일 경우 자동 생성
      await Directory(directory.path).create(recursive: true);

      // 지정한 경로에 사진 저장
      await File(file.path).copy('${directory.path}/${file.name}');
    } catch (e) {
      print('Error taking picture: $e');
    }
  }

  @override
  void dispose() {
    // 카메라 컨트롤러 해제
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 카메라가 준비되지 않으면 아무것도 띄우지 않음
    if (!controller.value.isInitialized) {
      return Container();
    }
    // 카메라 인터페이스와 위젯을 겹쳐 구성할 예정이므로 Stack 위젯 사용
    return Stack(
      children: [
        // 화면 전체를 차지하도록 Positioned.fill 위젯 사용
        Positioned.fill(
          // 카메라 촬영 화면이 보일 CameraPrivew
          child: CameraPreview(controller),
        ),
        // 하단 중앙에 위치도록 Align 위젯 설정
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
              padding: const EdgeInsets.all(15.0),
              // 버튼 클릭 이벤트 정의를 위한 GestureDetector
              child: GestureDetector(
                onTap: () {
                  // 사진 찍기 함수 호출
                  _takePicture();
                },
                // 버튼으로 표시될 Icon
                child: const Icon(
                  Icons.circle_outlined,
                  size: 70,
                  color: Colors.white,
                ),
              )),
        ),
      ],
    );
  }
}
