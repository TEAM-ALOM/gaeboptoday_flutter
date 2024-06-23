import 'package:flutter/material.dart';

Widget circleImage(String value, double height, bool isNetwork) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(100.0),
    child: isNetwork
        ? Image.network(
            'htt',
            height: height,
            errorBuilder: (context, error, stackTrace) {
              return Image.asset(
                'assets/images/defaultImg.png',
                height: height,
              );
            },
          )
        : Image.asset(
            value,
            height: height,
          ),
  );
}
