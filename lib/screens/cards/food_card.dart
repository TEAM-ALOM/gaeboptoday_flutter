import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gaeboptoday_flutter/models/menu_model.dart';
import 'package:gaeboptoday_flutter/screens/utils/circle_image.dart';
import 'package:gap/gap.dart';

Card foodCard(Food value) {
  return Card(
    color: Colors.white,
    child: SizedBox(
      height: 200,
      width: 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          circleImage(value.imagePath, 100, true),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AutoSizeText(
                value.name,
                maxLines: 1,
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const Gap(3),
          RatingBarIndicator(
            rating: value.rate,
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
