import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:jamesboard/icons/ic_star.dart';

import 'package:jamesboard/theme/Colors.dart';

class RatingBarBoardGameDetailReview extends StatelessWidget {
  final double initialRating;
  final int itemCount;
  final bool allowHalfRating;
  final ValueChanged<double>? onRatingUpdate;

  const RatingBarBoardGameDetailReview({
    super.key,
    required this.initialRating,
    this.itemCount = 5,
    this.allowHalfRating = true,
    this.onRatingUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: initialRating,
      minRating: 0,
      direction: Axis.horizontal,
      allowHalfRating: allowHalfRating,
      itemCount: itemCount,
      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, _) => Icon(
        IcStar as IconData?,
        color: mainGold,
      ),
      unratedColor: mainGrey,
      onRatingUpdate: onRatingUpdate ?? (rating) {},
    );
  }
}
