import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gaeboptoday_flutter/models/menu_model.dart';
import 'package:gap/gap.dart';

// autosize group
var fontSizeGroup = AutoSizeGroup();

Card menuCard(Menu value) {
  int leftMenuLength = value.length() ~/ 2;
  int rightMenuLength = value.length() - leftMenuLength;
  return Card(
    color: Colors.white,
    elevation: 1,
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            //w500 , w900
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: leftMenuLength,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                      bottom: leftMenuLength == 5 ? 8.0 : 5.0),
                                  child: AutoSizeText(
                                    maxLines: 2,
                                    value.menuList[index].name,
                                    // minFontSize: 14,
                                    // group: fontSizeGroup,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 13,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          const Gap(20),
                          Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: rightMenuLength,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                      bottom: rightMenuLength == 5 ? 8.0 : 5.0),
                                  child: AutoSizeText(
                                    value.menuList[index + leftMenuLength].name,
                                    // minFontSize: 14,
                                    // group: fontSizeGroup,
                                    maxLines: 2,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 13,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        value.menuRate.toStringAsFixed(1),
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 37,
                        ),
                      ),
                      // const Gap(3),
                      RatingBarIndicator(
                        rating: value.menuRate,
                        itemBuilder: (context, index) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        itemCount: 5,
                        itemSize: 12.0,
                        // direction: Axis.vertical,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // const Gap(5),
          // const Text(
          //   "점심 운영시간 : 10:30 ~ 16:30",
          //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          // ),
        ],
      ),
    ),
  );
}
