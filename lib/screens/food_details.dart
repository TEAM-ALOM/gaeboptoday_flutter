import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:gaeboptoday_flutter/controllers/get_review.dart';
import 'package:gaeboptoday_flutter/models/menu_model.dart';
import 'package:gap/gap.dart';
import 'package:vertical_barchart/vertical-barchart.dart';
import 'package:vertical_barchart/vertical-barchartmodel.dart';

class FoodDetails extends StatefulWidget {
  final Food value;
  const FoodDetails(this.value, {super.key});
  @override
  State<FoodDetails> createState() => _FoodDetailsState();
}

class _FoodDetailsState extends State<FoodDetails> {
  late Future<List<Review>> foodReview;
  late Food value;
  @override
  void initState() {
    value = widget.value;
    getData();
    super.initState();
  }

  void getData() async {
    foodReview = getFoodReviewData(widget.value);
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<VBarChartModel> bardata = [
    const VBarChartModel(
      index: 0,
      label: "5",
      colors: [Colors.amber, Colors.amber],
      jumlah: 179,
      tooltip: "179개",
    ),
    const VBarChartModel(
      index: 1,
      label: "4",
      colors: [Colors.amber, Colors.amber],
      jumlah: 123,
      tooltip: "123개",
    ),
    const VBarChartModel(
      index: 2,
      label: "3",
      colors: [Colors.amber, Colors.amber],
      jumlah: 121,
      tooltip: "121개",
    ),
    const VBarChartModel(
      index: 3,
      label: "2",
      colors: [Colors.amber, Colors.amber],
      jumlah: 4,
      tooltip: "4개",
    ),
    const VBarChartModel(
      index: 4,
      label: "1",
      colors: [Colors.amber, Colors.amber],
      jumlah: 7,
      tooltip: "7개",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.rate_review_outlined),
        onPressed: () {},
        label: const Text("리뷰 작성"),
      ),
      appBar: AppBar(
        // toolbarHeight: 0,
        backgroundColor: Colors.transparent,
        // foregroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 200,
              width: double.infinity,
              child: Image.network(
                value.imagePath,
                fit: BoxFit.fitWidth,
              ),
            ),
            const Gap(15),
            Text(
              value.name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
            ),
            Expanded(
              child: FutureBuilder(
                future: foodReview,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10),
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                // crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          value.rate.toStringAsFixed(1),
                                          style: const TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        RatingBarIndicator(
                                          rating: widget.value.rate,
                                          itemBuilder: (context, index) =>
                                              const Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          itemCount: 5,
                                          itemSize: 12.0,
                                          // direction: Axis.vertical,
                                        ),
                                        const Gap(5),
                                        Text("${snapshot.data!.length}개의 리뷰"),
                                        // const Gap(5),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: _buildGrafik(bardata),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const Gap(10),
                        Expanded(
                          child: Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                              ),
                              color: Color.fromRGBO(248, 248, 248, 1),
                            ),
                            child: Column(
                              children: [
                                const Gap(10),
                                AutoSizeText(
                                  maxLines: 1,
                                  "세종대학교 학생들의 ${value.name} 리뷰",
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                                const Gap(10),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30.0),
                                    child: AnimationLimiter(
                                      child: ListView.builder(
                                        padding: EdgeInsets.zero,
                                        shrinkWrap: true,
                                        // separatorBuilder: (context, index) =>
                                        //     const Divider(),
                                        itemCount: 50,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return AnimationConfiguration
                                              .staggeredList(
                                            position: index,
                                            duration: const Duration(
                                                milliseconds: 375),
                                            child: SlideAnimation(
                                              verticalOffset: 50.0,
                                              child: FadeInAnimation(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(6.0),
                                                  child: Card(
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 12.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          const Expanded(
                                                            flex: 1,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Icon(
                                                                  Icons.star,
                                                                  color: Colors
                                                                      .amber,
                                                                ),
                                                                Gap(5),
                                                                Text(
                                                                  "4.5",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          25,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 2,
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                AutoSizeText(
                                                                  maxLines: 1,
                                                                  snapshot
                                                                      .data!
                                                                      .first
                                                                      .writer,
                                                                  style: const TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                                AutoSizeText(
                                                                    maxLines: 3,
                                                                    snapshot
                                                                        .data!
                                                                        .first
                                                                        .review),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGrafik(List<VBarChartModel> bardata) {
    return VerticalBarchart(
      barSize: 5,
      // backdropColor: Colors.black,
      background: Colors.transparent,
      labelColor: const Color(0xff283137),
      tooltipColor: const Color(0xff8e97a0),
      maxX: 179,
      data: bardata,
      barStyle: BarStyle.DEFAULT,
    );
  }
}
