import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gaeboptoday_flutter/controllers/circle_image.dart';
import 'package:sliver_app_bar_builder/sliver_app_bar_builder.dart';

class Review extends StatefulWidget {
  const Review({super.key});

  @override
  State<Review> createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: ((context, innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBarBuilder(
            barHeight: 60,
            pinned: true,
            leadingActions: [
              (context, expandRatio, barHeight, overlapsContent) {
                return SizedBox(
                  height: barHeight,
                  // child: const BackButton(),
                );
              }
            ],
            initialContentHeight: 150,
            contentBuilder:
                (context, expandRatio, contentHeight, overlapsContent, flag) {
              return Container(
                alignment: Alignment.centerLeft,
                height: 60,
                transform: Matrix4.translationValues(
                    10 + (1 - expandRatio) * 10, 0, 0),
                child: Text(
                  '여러분의 계밥을 알려주세요!',
                  style: TextStyle(
                    fontSize: 15 + expandRatio * 10,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
          )
        ];
      }),
      body: ListView.builder(
        shrinkWrap: true,
        // physics: const NeverScrollableScrollPhysics(),
        itemCount: 6,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 120,
                  child: Row(
                    // mainAxisAlignment: main,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                          flex: 1,
                          child:
                              circleImage('assets/images/test_food.jpg', 100)),
                      Flexible(
                        flex: 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              "제육볶음",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            RatingBar.builder(
                              initialRating: 3,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemPadding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                print(rating); //TODO: UPDATE RATING ON FOOD
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
