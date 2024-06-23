import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gaeboptoday_flutter/controllers/get_menu.dart';
import 'package:gaeboptoday_flutter/models/menu_model.dart';
import 'package:gaeboptoday_flutter/screens/cards/food_card.dart';
import 'package:gap/gap.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AllMenusScreen extends StatefulWidget {
  const AllMenusScreen({super.key});

  @override
  State<AllMenusScreen> createState() => _AllMenusScreenState();
}

class _AllMenusScreenState extends State<AllMenusScreen> {
  List<Food> foodData = [];
  @override
  void initState() {
    dataLoad();
    super.initState();
  }

  void dataLoad() async {
    foodData = await getAllFoodData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.blueAccent,
        title: const Text(
          "계절밥상 전체 메뉴",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: foodData.isEmpty
          ? Center(
              child: LoadingAnimationWidget.inkDrop(
                color: Colors.blueAccent,
                size: 30,
              ),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: AnimationLimiter(
                child: AnimationConfiguration.staggeredGrid(
                  position: 2,
                  duration: const Duration(milliseconds: 385),
                  columnCount: 3,
                  child: SlideAnimation(
                    verticalOffset: 50.0,
                    child: FadeInAnimation(
                      child: MasonryGridView.count(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        itemCount: foodData.length,
                        itemBuilder: (context, index) {
                          return index == 1
                              ? const Gap(30)
                              : foodCard(foodData[index]);
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}

class Tile extends StatelessWidget {
  const Tile({
    super.key,
    required this.index,
    this.extent,
    this.backgroundColor,
    this.bottomSpace,
  });

  final int index;
  final double? extent;
  final double? bottomSpace;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final child = Container(
      color: backgroundColor ?? Colors.blue,
      height: extent,
      child: Center(
        child: CircleAvatar(
          minRadius: 20,
          maxRadius: 20,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          child: Text('$index', style: const TextStyle(fontSize: 20)),
        ),
      ),
    );

    if (bottomSpace == null) {
      return child;
    }

    return Column(
      children: [
        Expanded(child: child),
        Container(
          height: bottomSpace,
          color: Colors.green,
        )
      ],
    );
  }
}
