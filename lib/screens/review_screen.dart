import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gaeboptoday_flutter/controllers/circle_image.dart';

class Review extends StatefulWidget {
  const Review({super.key});

  @override
  State<Review> createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      // physics: const NeverScrollableScrollPhysics(),
      itemCount: 6,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child: Row(
            children: [
              circleImage('assets/images/test_food.jpg', 100),
              const Column(
                children: [],
              )
            ],
          ),
        );
      },
    );
  }
}
