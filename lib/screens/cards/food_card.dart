import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gaeboptoday_flutter/controllers/circle_image.dart';
import 'package:gap/gap.dart';
import 'package:like_button/like_button.dart';

Card foodCard() {
  return Card(
    color: Colors.white,
    child: SizedBox(
      height: 200,
      width: 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          circleImage('assets/images/test_food.jpg', 100),
          const SizedBox(
            height: 10,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "제육볶음",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const Gap(3),
          RatingBarIndicator(
            rating: 4.3,
            itemBuilder: (context, index) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            itemCount: 5,
            itemSize: 17.0,
            // direction: Axis.vertical,
          ),
        ],
      ),
    ),
  );
}
