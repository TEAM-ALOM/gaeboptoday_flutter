import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int value = 0;
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
                  current: value,
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
                  onChanged: (i) => setState(() => value = i),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              cardWidgetList[value].animate().fade(),
              Animate(
                effects: const [FadeEffect(), ScaleEffect()],
                child: cardWidgetList[value],
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
  const Card(
    elevation: 3,
    child: SizedBox(
      height: 400,
      child: Placeholder(),
    ),
  ),
  const Card(
    elevation: 3,
    child: SizedBox(
      height: 300,
      child: Placeholder(),
    ),
  ),
  const Card(
    elevation: 3,
    child: SizedBox(
      height: 400,
      child: Placeholder(),
    ),
  ),
];
List<List<String>> foodString = [
  ["asd", "asd", "asd", "asd", "asd", "asd", "asd", "asd", "asd", "asd", "asd"],
  ["asd", "asd", "asd", "asd", "asd", "asd", "asd", "asd", "asd", "asd", "asd"],
  ["asd", "asd", "asd", "asd", "asd", "asd", "asd", "asd", "asd", "asd", "asd"],
];
