import 'dart:async';
import 'dart:convert';

import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:card_loading/card_loading.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gaeboptoday_flutter/controllers/server_request.dart';
import 'package:gaeboptoday_flutter/screens/cards/food_card.dart';
import 'package:gaeboptoday_flutter/screens/cards/menu_card.dart';
import 'package:gaeboptoday_flutter/screens/cards/no_data_card.dart';
import 'package:gap/gap.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 1;
  final SwiperController _swiperController = SwiperController();
  late Map<String, List<String>> menuToday;
  @override
  void initState() {
    super.initState();
    waitForData();
  }

  void waitForData() async {
    menuToday = await getMenuData(6, 7);
    print(menuToday);
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
              const Text(
                "좋은 아침이에요! 👨🏻‍🍳",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
              ),
              const Text(
                "오늘의 계밥 식단입니다.",
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 15),
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
      0 => Colors.blueAccent,
      1 => Colors.blueAccent,
      2 => Colors.blueAccent,
      _ => Colors.blueAccent,
    };
List<Card> cardWidgetList = [
  noDataCard("현재 천원의 아침밥은 식단표 제공이 되지 않습니다."),
  Card(
    child: LoadingAnimationWidget.inkDrop(
      color: Colors.blueAccent,
      size: 30,
    ),
  ),
  menuCard(foodString[2], 4.5),
];
//TODO: USE CARD + FUTURE BUILDER to manage data card
List<List<String>> foodString = [
  ["딸기", "당근", "수박", "제육볶음", "메론", "게임", "딸기", "당근", "수박", "참외", "메론", "게임"],
  ["asd", "asd", "asd", "asd", "asd", "asd", "asd", "asd", "asd", "asd", "asd"],
  ["asd", "asd", "asd", "asd", "asd", "asd", "asd", "asd", "asd", "asd", "asd"],
];
