import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

Card noDataCard(
    {required String icon, required String text, String? secondText}) {
  return Card(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          icon,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
        const Gap(10),
        AutoSizeText(
          text,
          minFontSize: 13,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        secondText != null
            ? AutoSizeText(
                secondText,
                minFontSize: 8,
                style: const TextStyle(
                    fontWeight: FontWeight.normal, fontSize: 12),
              )
            : const Gap(0),
      ],
    ),
  );
}
