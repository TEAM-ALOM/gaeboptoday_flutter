import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gaeboptoday_flutter/screens/cards/food_card.dart';
import 'package:gaeboptoday_flutter/screens/cards/menu_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  final SwiperController _swiperController = SwiperController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          // backgroundColor: Colors.white,s
          // backgroundColor: const Color(0x44000000),
          elevation: 0,
          // title: const Text("Title"),
        ),
      ),
      // backgroundColor: Colors.gr,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const Text(
                "좋은 아침이에요! 👨🏻‍🍳",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              const Text(
                "오늘의 계밥 식단입니다.",
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 19),
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
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: Offset(0, 1.5),
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
              const SizedBox(
                height: 20,
              ),

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
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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
  menuCard(foodString[0], 4.5),
  menuCard(foodString[1], 4.5),
  menuCard(foodString[2], 4.5),
];
List<List<String>> foodString = [
  ["딸기", "당근", "수박", "제육볶음", "메론", "게임", "딸기", "당근", "수박", "참외", "메론", "게임"],
  ["asd", "asd", "asd", "asd", "asd", "asd", "asd", "asd", "asd", "asd", "asd"],
  ["asd", "asd", "asd", "asd", "asd", "asd", "asd", "asd", "asd", "asd", "asd"],
];
