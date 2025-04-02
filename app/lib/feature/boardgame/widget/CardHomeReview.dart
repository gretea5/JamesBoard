import 'package:flutter/material.dart';
import 'package:jamesboard/constants/FontString.dart';
import 'package:jamesboard/theme/Colors.dart';
import 'package:provider/provider.dart';

import '../viewmodel/BoardGameViewModel.dart';
import '../viewmodel/CategoryGameViewModel.dart';

class CardHomeReview extends StatefulWidget {
  final String title;
  final List<Map<String, String>> images;
  final Function(int) onImageTap;
  final Map<String, dynamic> queryParameters;

  const CardHomeReview({
    Key? key,
    required this.title,
    required this.images,
    required this.onImageTap,
    required this.queryParameters,
  }) : super(key: key);

  @override
  State<CardHomeReview> createState() => _CardHomeReviewState();
}

class _CardHomeReviewState extends State<CardHomeReview> {
  late BoardGameViewModel viewModel;

  @override
  void initState() {
    super.initState();

    final categoryViewModel =
        Provider.of<CategoryGameViewModel>(context, listen: false);
    viewModel = categoryViewModel.getCategoryViewModel(widget.title);
    viewModel.getTopGames(widget.queryParameters);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<BoardGameViewModel>(builder: (context, viewModel, child) {
        if (viewModel.isLoading) {
          return Center(
            child: CircularProgressIndicator(color: mainGold),
          );
        }

        final games = viewModel.topGames;

        return LayoutBuilder(
          builder: (context, constraints) {
            double itemWidth = 180;
            double height = itemWidth * (10 / 17);
            return SizedBox(
              height: height * 3,
              child: GridView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                // 콘텐츠 크기에 맞게 GridView 크기 조정
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, // 3개의 아이템
                    childAspectRatio: 8 / 17, // 비율
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8),
                itemCount: widget.images.length,
                itemBuilder: (context, index) {
                  final imageUrl = games[index].gameImage;
                  final id = games[index].gameId;
                  return Container(
                    child: GestureDetector(
                      onTap: () => widget.onImageTap(id),
                      child: Container(
                        width: itemWidth * 1.2,
                        child: Row(
                          children: [
                            Container(
                              width: itemWidth,
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  // 이미지를 오른쪽으로 옮기기 위해 Transform 사용
                                  Transform.translate(
                                    offset: Offset(itemWidth * 0.175, 0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        imageUrl,
                                        width: itemWidth,
                                        height: height,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: -height * 0.15,
                                    child: Text(
                                      '${index + 1}',
                                      style: TextStyle(
                                        fontSize: height, // 숫자 크기 조정
                                        fontFamily: FontString.pretendardBold,
                                        foreground: Paint()
                                          ..style = PaintingStyle.stroke
                                          ..strokeWidth = 5 // 테두리 두께
                                          ..color = mainGold, // 외곽선 색상
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: -height * 0.15,
                                    child: Text(
                                      '${index + 1}',
                                      style: TextStyle(
                                        fontSize: height,
                                        fontFamily: FontString.pretendardBold,
                                        color: mainRed, // 내부 색상
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        );
      }),
    );
  }
}
