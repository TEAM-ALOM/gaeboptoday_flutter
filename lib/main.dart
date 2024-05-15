import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:gaeboptoday_flutter/screens/camera_screen.dart';
import 'package:gaeboptoday_flutter/screens/home_screen.dart';
import 'package:gaeboptoday_flutter/screens/monthly_view_screen.dart';
import 'package:gaeboptoday_flutter/screens/mypage_screen.dart';
import 'package:gaeboptoday_flutter/screens/review_screen.dart';

List<TabItem> items = [
  const TabItem(
    icon: Icons.home,
    title: '홈',
  ),
  const TabItem(
    icon: Icons.calendar_month,
    title: '월간계밥',
  ),
  const TabItem(
    icon: Icons.star,
    title: '리뷰',
  ),
  const TabItem(
    icon: Icons.account_circle,
    title: '마이페이지',
  ),
  // TabItem(
  //   icon: Icons.account_box,
  //   title: 'profile',
  // ),
];
const List<Widget> viewWidgets = [
  HomeScreen(),
  MonthlyView(),
  Review(),
  MyPage(),
];
// 사용가능한 카메라 장치의 목록을 저장하는 변수
late List<CameraDescription> _cameras;
Future<void> main() async {
  // 앱이 실행되기 전에 필요한 초기화 작업을 수행하는 메서드
  // main 함수에서만 호출 가능
  // 사용가능한 카메라를 확인하기 위함
  WidgetsFlutterBinding.ensureInitialized();

  // 사용 가능한 카메라 확인
  _cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Pretendard',
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
      ),
      home: const BottomBarWidget(),
    );
  }
}

class BottomBarWidget extends StatefulWidget {
  const BottomBarWidget({
    super.key,
    // required this.title,
  });

  // final String title;

  @override
  _BottomBarWidgetState createState() => _BottomBarWidgetState();
}

class _BottomBarWidgetState extends State<BottomBarWidget> {
  int visit = 0;
  double height = 30;
  // Color colorSelect = Colors.white;
  Color colorSelect = const Color(0XFF0686F8);

  Color color = const Color.fromARGB(255, 164, 224, 249);
  // Color color2 = const Color(0XFF96B1FD);
  Color color2 = const Color.fromRGBO(255, 255, 255, 1);
  // Color color2 = const Color.fromRGBO(255, 255, 255, 1);

  // Color bgColor = const Color.fromRGBO(66, 126, 238, 255);
  Color bgColor = const Color.fromARGB(255, 66, 126, 238);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.camera),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => CameraScreen(
                      cameras: _cameras,
                    )));
          }),
      body: viewWidgets[visit],
      bottomNavigationBar: BottomBarInspiredInside(
        items: items,
        backgroundColor: Colors.white,
        color: bgColor,
        colorSelected: color2,
        indexSelected: visit,
        onTap: (int index) => setState(() {
          visit = index;
          print(visit);
        }),
        chipStyle: const ChipStyle(convexBridge: true),
        itemStyle: ItemStyle.circle,
        animated: true,
      ),
    );
  }
}
