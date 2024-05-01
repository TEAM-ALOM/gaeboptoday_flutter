import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

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
      appBar: AppBar(
        elevation: 1,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Text("4월 30일 존맛탱구리 식사"),
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
                          fontWeight: FontWeight.bold),
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
                height: 10,
              ),

              SizedBox(
                height: 200,
                child: Swiper(
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
  Card(
    elevation: 3,
    child: Text(foodString[1].toString()),
  ),
  const Card(
    elevation: 3,
    child: Text("2"),
  ),
  const Card(
    elevation: 3,
    child: Text("3"),
  ),
];
List<List<String>> foodString = [
  ["asd", "asd", "asd", "asd", "asd", "asd", "asd", "asd", "asd", "asd", "asd"],
  ["asd", "asd", "asd", "asd", "asd", "asd", "asd", "asd", "asd", "asd", "asd"],
  ["asd", "asd", "asd", "asd", "asd", "asd", "asd", "asd", "asd", "asd", "asd"],
];
