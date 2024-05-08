import 'package:flutter/material.dart';

Widget circleImage(String value, double height) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(100.0),
    child: Image.asset(
      value,
      height: height,
    ),
  );
}
