import 'package:animations/animations.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gaeboptoday_flutter/models/menu_model.dart';
import 'package:gaeboptoday_flutter/screens/utils/circle_image.dart';
import 'package:gap/gap.dart';

OpenContainer foodCard(Food value) {
  return OpenContainer(
    closedShape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    closedElevation: 1,
    openBuilder: (context, __) {
      return SwipeToDismissWrap(
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 0,
          ),
          body: const SingleChildScrollView(
            child: Column(
              children: [],
            ),
          ),
        ),
      );
    },
    closedBuilder: (context, action) {
      return SizedBox(
        height: 200,
        width: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            circleImage(value.imagePath, 100, true),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AutoSizeText(
                  value.name,
                  maxLines: 1,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Gap(3),
            RatingBarIndicator(
              rating: value.rate,
              itemBuilder: (context, index) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              itemCount: 5,
              itemSize: 17.0,
              // direction: Axis.vertical,
            ),
          ],
        ),
      );
    },
  );
}

class SwipeToDismissWrap extends StatefulWidget {
  final Widget child;

  const SwipeToDismissWrap({super.key, required this.child});

  @override
  State<SwipeToDismissWrap> createState() => _SwipeToDismissWrapState();
}

class _SwipeToDismissWrapState extends State<SwipeToDismissWrap> {
  bool _swipeInProgress = false;
  late double _startPosX;

  final double _swipeStartAreaWidth = 60;
  final double _swipeMinLength = 50;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragStart: (details) {
        if (details.localPosition.dx < _swipeStartAreaWidth) {
          _swipeInProgress = true;
          _startPosX = details.localPosition.dx;
        }
      },
      onHorizontalDragUpdate: (details) {
        if (_swipeInProgress &&
            details.localPosition.dx > _startPosX + _swipeMinLength) {
          HapticFeedback.mediumImpact();
          Navigator.of(context).pop();
        }
      },
      onHorizontalDragEnd: (_) => _swipeInProgress = false,
      child: widget.child,
    );
  }
}
