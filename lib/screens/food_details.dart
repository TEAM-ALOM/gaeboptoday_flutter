import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gaeboptoday_flutter/controllers/get_review.dart';
import 'package:gaeboptoday_flutter/models/menu_model.dart';
import 'package:gap/gap.dart';

class FoodDetails extends StatefulWidget {
  final Food value;
  const FoodDetails(this.value, {super.key});
  @override
  State<FoodDetails> createState() => _FoodDetailsState();
}

class _FoodDetailsState extends State<FoodDetails> {
  late List<Review> foodReview;
  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    foodReview = await getFoodReviewData(widget.value);
    for (var data in foodReview) {
      print(data.review);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 200,
              width: double.infinity,
              child: Image.network(
                widget.value.imagePath,
                fit: BoxFit.fitWidth,
              ),
            ),
            const Gap(30),
            Text(
              widget.value.name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
            ),
            RatingBarIndicator(
              rating: widget.value.rate,
              itemBuilder: (context, index) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              itemCount: 5,
              itemSize: 17.0,
              // direction: Axis.vertical,
            ),
            const SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [Text("asd")],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
