import 'package:flutter/material.dart';
import 'package:jamesboard/constants/FontString.dart';
import 'package:jamesboard/feature/boardgame/widget/CardHomeReview.dart';
import 'package:jamesboard/util/dummy/AppDummyData.dart';

import '../../../theme/Colors.dart';

class ListBGGRankGame extends StatefulWidget {
  final List<String> imageUrls; // 게임 이미지 URL 리스트
  final String title;
  final Function(int id) onImageTap; // 클릭 시 수행할 작업
  final Map<String, dynamic> queryParameters;

  const ListBGGRankGame({
    Key? key,
    required this.imageUrls,
    required this.title,
    required this.onImageTap,
    required this.queryParameters,
  }) : super(key: key);

  @override
  State<ListBGGRankGame> createState() => _ListHomeHorizontalGameState();
}

class _ListHomeHorizontalGameState extends State<ListBGGRankGame> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 32, left: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: TextStyle(
                  fontSize: 22,
                  fontFamily: FontString.pretendardMedium,
                  color: mainWhite,
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          CardHomeReview(
            title: widget.title,
            images: AppDummyData.images,
            onImageTap: (int id) => {widget.onImageTap(id)},
            queryParameters: widget.queryParameters,
          )
        ],
      ),
    );
  }
}
