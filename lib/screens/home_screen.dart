import 'dart:async';

import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gaeboptoday_flutter/controllers/server_request.dart';
import 'package:gaeboptoday_flutter/screens/cards/food_card.dart';
import 'package:gaeboptoday_flutter/screens/cards/menu_card.dart';
import 'package:gaeboptoday_flutter/screens/cards/no_data_card.dart';
import 'package:gap/gap.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final now = DateTime.now();
  final SwiperController _swiperController = SwiperController();

  late int timeCalculate;
  late StreamSubscription<InternetConnectionStatus> listener;
  late Map<String, List<String>> menuToday;

  List<String> timeName = ["아침", "점심", "저녁"];
  int currentIndex = 1, initIndex = 1;

  @override
  void initState() {
    timeCalculate = now.hour * 60 + now.minute;
    initIndex = (timeCalculate < 10 * 60 + 30)
        ? 0
        : (timeCalculate < 16 * 60 + 30)
            ? 1
            : 2;
    currentIndex = initIndex;
    super.initState();
    waitForInternet();
  }

  @override
  void dispose() {
    // listener.cancel();
    super.dispose();
  }

  List<Card> cardWidgetList = [
    noDataCard(icon: "🙅🏻‍♂️", text: "현재 천원의 아침밥은 식단표 제공이 되지 않습니다."),
    Card(
      child: LoadingAnimationWidget.inkDrop(
        color: Colors.blueAccent,
        size: 30,
      ),
    ),
    Card(
      child: LoadingAnimationWidget.inkDrop(
        color: Colors.blueAccent,
        size: 30,
      ),
    ),
  ];
  void waitForInternet() async {
    dataLoad();
    // listener = InternetConnectionChecker().onStatusChange.listen(
    //   (InternetConnectionStatus status) {
    //     switch (status) {
    //       case InternetConnectionStatus.connected:
    //         print('Data connection is available.');
    //         dataLoad();
    //         break;
    //       case InternetConnectionStatus.disconnected:
    //         internetDisconnected();
    //         print('You are disconnected from the internet.');
    //         break;
    //     }
    //   },
    // );
  }

  void internetDisconnected() {
    setState(() {
      cardWidgetList = [
        noDataCard(icon: "⚠️", text: "인터넷이 연결을 확인해주세요"),
        noDataCard(icon: "⚠️", text: "인터넷이 연결을 확인해주세요"),
        noDataCard(icon: "⚠️", text: "인터넷이 연결을 확인해주세요"),
      ];
    });
  }

  void dataLoad() async {
    // menuToday = await getMenuData(6, 7);
    menuToday = await getMenuData(now.month, now.day);
    setState(() {
      print(menuToday['lunch']);

      cardWidgetList[0] =
          noDataCard(icon: "🙅🏻‍♂️", text: "현재 천원의 아침밥은 식단표 제공이 되지 않습니다.");
      cardWidgetList[1] = menuToday['lunch']!.isNotEmpty
          ? menuCard(menuToday['lunch']!, 3.9)
          : noDataCard(
              icon: "👩🏻‍🍳",
              text: "식당 휴무일 이거나 식단이 등록되지 않았습니다.",
              secondText: "계절밥상은 토요일, 일요일, 공휴일에 쉽니다.",
            );
      cardWidgetList[2] = menuToday['dinner']!.isNotEmpty
          ? menuCard(menuToday['dinner']!, 4.4)
          : noDataCard(
              icon: "👨🏻‍🍳",
              text: "식당 휴무일 이거나 식단이 등록되지 않았습니다.",
              secondText: "계절밥상은 토요일, 일요일, 공휴일에 쉽니다.",
            );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          elevation: 0,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Text(
                "좋은 ${timeName[initIndex]}이에요! 👨🏻‍🍳",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
              ),
              Text(
                "${now.month}월 ${now.day}일의 계절밥상입니다.",
                style: const TextStyle(
                    fontWeight: FontWeight.normal, fontSize: 15),
              ),
              const SizedBox(height: 20),
              Center(
                child: AnimatedToggleSwitch<int>.size(
                  current: currentIndex,
                  values: const [0, 1, 2],
                  iconOpacity: 0.2,
                  indicatorSize: const Size.fromWidth(100),
                  // iconBuilder: iconBuilder,
                  customIconBuilder: (context, local, global) {
                    final text = const ['아침', '점심', '저녁'][local.index];
                    return Center(
                        child: Text(
                      text,
                      style: TextStyle(
                        fontSize: 13,
                        color: Color.lerp(
                            Colors.black, Colors.white, local.animationValue),
                        fontWeight: currentIndex != local.index
                            ? FontWeight.normal
                            : FontWeight.bold,
                      ),
                    ));
                  },
                  borderWidth: 4.0,
                  iconAnimationType: AnimationType.onHover,
                  style: ToggleStyle(
                    borderColor: Colors.transparent,
                    borderRadius: BorderRadius.circular(25.0),
                    boxShadow: [
                      const BoxShadow(
                        color: Colors.black26,
                        spreadRadius: 0.1,
                        blurRadius: 1,
                        offset: Offset(0, 0.3),
                      ),
                    ],
                  ),
                  styleBuilder: (i) =>
                      ToggleStyle(indicatorColor: colorBuilder(i)),
                  onChanged: (i) => setState(() {
                    currentIndex = i;
                    _swiperController.move(currentIndex);
                  }),
                ),
              ),
              const Gap(20),

              SizedBox(
                height: 200,
                child: Swiper(
                  loop: false,
                  itemBuilder: (BuildContext context, int index) {
                    return cardWidgetList[index];
                  },
                  onIndexChanged: (v) => setState(() {
                    currentIndex = v;
                  }),
                  index: currentIndex,
                  itemCount: cardWidgetList.length,
                  viewportFraction: 1,
                  scale: 0.8,
                  controller: _swiperController,
                ),
              ),
              // Animate(
              //   effects: const [FadeEffect(), ScaleEffect()],
              //   child:
              // ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "인기 메뉴를 살펴보세요!",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    foodCard(),
                    foodCard(),
                    foodCard(),
                    foodCard(),
                    foodCard(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Color colorBuilder(int value) => switch (value) {
      _ => Colors.blueAccent,
    };
