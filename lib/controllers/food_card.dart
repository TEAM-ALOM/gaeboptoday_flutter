import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

Card foodCard() {
  return Card(
    child: SizedBox(
      height: 200,
      width: 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(100.0),
            child: Image.asset(
              'assets/images/test_food.jpg',
              height: 100,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "제육볶음",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          RatingBarIndicator(
            rating: 4.3,
            itemBuilder: (context, index) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            itemCount: 5,
            itemSize: 20.0,
            // direction: Axis.vertical,
          ),
        ],
      ),
    ),
  );
}
