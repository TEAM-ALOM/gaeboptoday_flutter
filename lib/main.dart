import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';
import 'package:flutter/material.dart';
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:gaeboptoday_flutter/screens/home_screen.dart';
import 'package:gaeboptoday_flutter/screens/monthly_view_screen.dart';
import 'package:gaeboptoday_flutter/screens/mypage_screen.dart';
import 'package:gaeboptoday_flutter/screens/review_screen.dart';

List<TabItem> items = [
  const TabItem(
    icon: Icons.home,
    // title: '홈',
  ),
  const TabItem(
    icon: Icons.calendar_month,
    // title: '월간 보기',
  ),
  const TabItem(
    icon: Icons.star,
    // title: '리뷰',
  ),
  const TabItem(
    icon: Icons.account_circle,
    // title: 'Cart',
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
void main() {
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
  Color colorSelect = const Color(0XFF0686F8);
  Color color = const Color.fromARGB(255, 78, 136, 186);
  Color color2 = const Color(0XFF96B1FD);
  Color bgColor = const Color(0XFF1752FE);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
      body: viewWidgets[visit],
      bottomNavigationBar: BottomBarInspiredInside(
        items: items,
        backgroundColor: Colors.white,
        color: color2,
        colorSelected: Colors.white,
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
