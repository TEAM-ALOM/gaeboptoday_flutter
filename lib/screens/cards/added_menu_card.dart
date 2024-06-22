import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gaeboptoday_flutter/models/menu_model.dart';
import 'package:gaeboptoday_flutter/screens/cards/no_data_card.dart';
import 'package:gap/gap.dart';

// autosize group
var fontSizeGroup = AutoSizeGroup();
//TODO : MenuModel value ver change
Card addedMenuCard(MenuModel value) {
  int lunchLeft = value.lunch.length() ~/ 2;
  int lunchRight = value.lunch.length() - lunchLeft;
  int dinnerLeft = value.dinner.length() ~/ 2;
  int dinnerRight = value.dinner.length() - dinnerLeft;

  if (value.lunch.isEmpty()) {
    //no data on holidays
    return noDataCard(icon: "🙅🏻‍♂️", text: "공휴일은 운영하지 않습니다.");
  } else {
    return Card(
      color: Colors.white,
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 1,
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Transform.translate(
                    offset: const Offset(-20, 0),
                    child: Container(
                      height: 28,
                      width: 65,
                      color: Colors.transparent,
                    ),
                  ),
                  const Text(
                    "점심",
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                        color: Colors.blueAccent),
                  ),
                ],
              ),
            ),
            const Gap(5),
            Flexible(
              flex: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: lunchLeft,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: EdgeInsets.only(
                              bottom: lunchLeft == 5 ? 8.0 : 5.0),
                          child: AutoSizeText(
                            maxLines: 1,
                            value.lunch.menuList[index].name,
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
                  Flexible(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 5,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: EdgeInsets.only(
                              bottom: lunchRight == 5 ? 8.0 : 5.0),
                          child: AutoSizeText(
                            value.lunch.menuList[index + lunchLeft].name,
                            // minFontSize: 14,
                            // group: fontSizeGroup,
                            maxLines: 1,
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
            ),
            const Gap(10),
            Flexible(
              flex: 1,
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Transform.translate(
                    offset: const Offset(-20, 0),
                    child: Container(
                      height: 28,
                      width: 65,
                      color: Colors.transparent,
                    ),
                  ),
                  const Text(
                    "저녁",
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                        color: Colors.blueAccent),
                  ),
                ],
              ),
            ),
            const Gap(5),
            Flexible(
              flex: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    //w500 , w900
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: dinnerLeft,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: EdgeInsets.only(
                              bottom: dinnerLeft == 5 ? 8.0 : 5.0),
                          child: AutoSizeText(
                            maxLines: 1,
                            value.dinner.menuList[index].name,
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
                  Flexible(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: dinnerRight,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: EdgeInsets.only(
                              bottom: dinnerRight == 5 ? 8.0 : 5.0),
                          child: AutoSizeText(
                            value.dinner.menuList[index + dinnerLeft].name,
                            // minFontSize: 14,
                            // group: fontSizeGroup,
                            maxLines: 1,
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
            ),
          ],
        ),
      ),
    );
  }
}
