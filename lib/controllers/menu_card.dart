import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

Card menuCard(List<String> value, double rate) {
  return Card(
    color: Colors.white,
    elevation: 1,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Flexible(
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: value.length - 5,
            itemBuilder: (BuildContext context, int index) {
              return Text(value[index]);
            },
          ),
        ),
        Flexible(
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: value.length - 6,
            itemBuilder: (BuildContext context, int index) {
              return Text(value[index + 5]);
            },
          ),
        ),
        Flexible(
          flex: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                rate.toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              RatingBarIndicator(
                rating: rate,
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
      ],
    ),
  );
}
