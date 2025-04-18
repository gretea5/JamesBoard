import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jamesboard/constants/FontString.dart';
import 'package:jamesboard/constants/IconPath.dart';
import 'package:jamesboard/feature/boardgame/screen/BoardGameImageScreen.dart';
import 'package:jamesboard/feature/boardgame/viewmodel/CategoryGameViewModel.dart';
import 'package:jamesboard/feature/boardgame/widget/button/ButtonBoardRatingGame.dart';
import 'package:jamesboard/main.dart';
import 'package:jamesboard/theme/Colors.dart';
import 'package:jamesboard/util/CommonUtils.dart';
import 'package:jamesboard/widget/button/ButtonCommonGameTag.dart';
import 'package:jamesboard/widget/button/ButtonCommonPrimaryBottom.dart';
import 'package:marquee/marquee.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../constants/AppString.dart';
import '../../../util/BottomSheetUtil.dart';
import '../viewmodel/BoardGameViewModel.dart';
import '../viewmodel/UserActivityViewModel.dart';
import '../widget/BoardGameDetailGameList.dart';
import '../widget/skeleton/BoardGameDetailSkeleton.dart';

class BoardGameDetailScreen extends StatefulWidget {
  final int gameId;

  const BoardGameDetailScreen({super.key, required this.gameId});

  @override
  State<BoardGameDetailScreen> createState() => _BoardGameDetailScreenState();
}

class _BoardGameDetailScreenState extends State<BoardGameDetailScreen> {
  late BoardGameViewModel viewModel;
  late UserActivityViewModel userActivityViewModel;
  late double myRating;

  bool hasUserRated = false;

  @override
  void initState() {
    super.initState();
    final categoryViewModel =
        Provider.of<CategoryGameViewModel>(context, listen: false);
    viewModel =
        categoryViewModel.getCategoryViewModel(widget.gameId.toString());
    viewModel.getBoardGameDetail(widget.gameId);

    _loadData();
  }

  Future<void> _loadData() async {
    String userIdStr = await storage.read(key: 'userId') ?? '';
    int userId = int.parse(userIdStr);

    userActivityViewModel =
        Provider.of<UserActivityViewModel>(context, listen: false);
    await userActivityViewModel.getUserActivityDetail(
      userId: userId,
      gameId: widget.gameId,
    );

    setState(() {
      myRating =
          userActivityViewModel.userActivityDetail?.userActivityRating ?? 0.0;
      hasUserRated = userActivityViewModel.hasUserRated;
    });
  }

  Future<void> _showRatingBottomSheet() async {
    final updatedRating = await BottomSheetUtil.showRatingBottomSheet(
      context,
      gameId: widget.gameId,
      myRating: myRating,
    );

    // 바텀시트에서 별점이 수정된 경우만 업데이트
    if (updatedRating != null && updatedRating != myRating) {
      setState(() {
        myRating = updatedRating;
        hasUserRated = updatedRating > 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Scaffold(
        backgroundColor: mainBlack,
        body: SafeArea(
          child: Consumer<BoardGameViewModel>(
            builder: (context, viewModel, child) {
              if (viewModel.isLoading) {
                return BoardGameDetailSkeleton();
              }
              final boardGameDetail = viewModel.boardGameDetail;

              if (boardGameDetail == null) {
                return Center(
                  child: Text(
                    AppString.noGames,
                    style: TextStyle(
                      color: mainWhite,
                    ),
                  ),
                );
              }

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BoardGameImageScreen(
                                    imageUrl: boardGameDetail.gameImage,
                                  ),
                                ),
                              );
                            },
                            child: Image.network(
                              boardGameDetail
                                  .gameImage, // Image URL from view model
                              height: MediaQuery.of(context).size.height * 0.35,
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 12,
                          left: 12,
                          child: Container(
                            decoration: BoxDecoration(
                              color: secondaryBlack,
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              icon: Icon(
                                Icons.chevron_left,
                                color: mainWhite,
                                size: 30,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.only(left: 20),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent, // 위쪽은 투명
                                  shadowBlack.withOpacity(0.8), // 아래로 갈수록 진하게
                                ],
                              ),
                            ),
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                // 텍스트 크기 측정
                                final textPainter = TextPainter(
                                  text: TextSpan(
                                    text: boardGameDetail.gameTitle,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 44,
                                      fontFamily: 'Pretendard-Bold',
                                    ),
                                  ),
                                  maxLines: 1,
                                  textDirection: TextDirection.ltr,
                                )..layout(
                                    maxWidth:
                                        constraints.maxWidth - 20); // 패딩 고려

                                final isOverflowing = textPainter
                                    .didExceedMaxLines; // 텍스트가 넘치는지 확인

                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    isOverflowing
                                        ? SizedBox(
                                            width: constraints.maxWidth -
                                                20, // 패딩 고려
                                            height: 50, // 높이 조정
                                            child: Marquee(
                                              text: boardGameDetail.gameTitle,
                                              style: TextStyle(
                                                color: mainWhite,
                                                fontSize: 44,
                                                fontFamily:
                                                    FontString.pretendardBold,
                                              ),
                                              scrollAxis: Axis.horizontal,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              blankSpace: 50.0,
                                              velocity: 30.0,
                                            ),
                                          )
                                        : Text(
                                            boardGameDetail.gameTitle,
                                            style: TextStyle(
                                              color: mainWhite,
                                              fontSize: 44,
                                              fontFamily: 'Pretendard-Bold',
                                            ),
                                          ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 8),
                              child: ButtonCommonGameTag(
                                text: "${boardGameDetail.gameMinAge}세",
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(right: 8),
                              child: ButtonCommonGameTag(
                                text: '${boardGameDetail.gameYear}년',
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(right: 8),
                              child: ButtonCommonGameTag(
                                text: CommonUtils.getDifficulty(
                                  boardGameDetail.difficulty,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(right: 8),
                              child: ButtonCommonGameTag(
                                text: CommonUtils.getAgeInfo(
                                  boardGameDetail.minPlayers,
                                  boardGameDetail.maxPlayers,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(right: 8),
                              child: ButtonCommonGameTag(
                                text: '${boardGameDetail.playTime}분',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: 20,
                        top: 12,
                      ),
                      child: Text(
                        boardGameDetail.gameCategories.join(" • "),
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: FontString.pretendardMedium,
                          color: mainGrey,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: 20,
                        right: 20,
                        top: 24,
                      ),
                      child: ButtonBoardRatingGame(
                        gameId: widget.gameId,
                        rating: boardGameDetail.gameRating,
                        onPressed: _showRatingBottomSheet,
                        disableWithOpacity: false,
                        hasUserRated: hasUserRated,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        left: 20,
                        top: 24,
                        right: 20,
                      ),
                      child: Text(
                        boardGameDetail.description,
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: FontString.pretendardMedium,
                            color: mainWhite),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        right: 20,
                        top: 16,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              BottomSheetUtil.showBoardGameDetailBottomSheet(
                                context,
                                boardGameDetail: boardGameDetail,
                              );
                            },
                            child: Text(
                              AppString.seeMore,
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: FontString.pretendardMedium,
                                color: mainGrey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: 24,
                        left: 20,
                        right: 20,
                      ),
                      child: Divider(
                        color: mainGrey,
                        thickness: 1, // 두께 설정
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: 24,
                        left: 20,
                        right: 20,
                      ),
                      child: Text(
                        AppString.similarMission,
                        style: TextStyle(
                          fontSize: 22,
                          fontFamily: FontString.pretendardBold,
                          color: mainWhite,
                        ),
                      ),
                    ),
                    BoardGameDetailGameList(
                      gameId: widget.gameId,
                      category: boardGameDetail.gameCategories[Random()
                          .nextInt(boardGameDetail.gameCategories.length)],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
