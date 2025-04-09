import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jamesboard/constants/AppString.dart';
import 'package:jamesboard/constants/FontString.dart';
import 'package:jamesboard/constants/IconPath.dart';
import 'package:jamesboard/theme/Colors.dart';
import 'package:jamesboard/util/CommonUtils.dart';
import 'package:provider/provider.dart';

import '../../viewmodel/BoardGameViewModel.dart';
import '../../viewmodel/CategoryGameViewModel.dart';

class ButtonBoardRatingGame extends StatefulWidget {
  final int gameId;
  final double rating;
  final VoidCallback? onPressed;
  final bool disableWithOpacity;
  final bool hasUserRated;

  const ButtonBoardRatingGame({
    super.key,
    required this.gameId,
    required this.rating,
    required this.onPressed,
    required this.disableWithOpacity,
    required this.hasUserRated,
  });

  @override
  State<ButtonBoardRatingGame> createState() => _ButtonBoardRatingGameState();
}

class _ButtonBoardRatingGameState extends State<ButtonBoardRatingGame> {
  late BoardGameViewModel ratingViewModel;

  @override
  void initState() {
    super.initState();

    final categoryViewModel =
        Provider.of<CategoryGameViewModel>(context, listen: false);
    ratingViewModel =
        categoryViewModel.getCategoryViewModel("${widget.gameId}rating");
  }

  @override
  Widget build(BuildContext context) {
    final isDisabled = widget.onPressed == null;

    return ChangeNotifierProvider.value(
      value: ratingViewModel,
      child: Opacity(
        opacity: isDisabled && widget.disableWithOpacity ? 0.4 : 1.0,
        child: SizedBox(
          width: double.infinity,
          height: 56,
          child: IntrinsicHeight(
            child: AbsorbPointer(
              absorbing: isDisabled && widget.disableWithOpacity,
              child: ElevatedButton(
                onPressed: () {
                  widget.onPressed!();
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  backgroundColor: secondaryBlack,
                  padding: EdgeInsets.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Consumer<BoardGameViewModel>(
                  builder: (context, viewModel, child) {
                    return Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "${AppString.evaluation}\u00A0",
                            style: TextStyle(
                              color: mainWhite,
                              fontSize: 16,
                              fontFamily: FontString.pretendardBold,
                            ),
                          ),
                          TextSpan(
                            text: "(${CommonUtils.roundToTwoDecimalPlaces(
                              viewModel.boardGameDetail?.gameRating ??
                                  widget.rating,
                            )})",
                            style: TextStyle(
                              color: mainGold,
                              fontSize: 16,
                              fontFamily: FontString.pretendardBold,
                            ),
                          ),

                          // 평가를 했다면
                          if (widget.hasUserRated)
                            WidgetSpan(
                              alignment: PlaceholderAlignment.middle,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 6.0),
                                child: SvgPicture.asset(
                                  IconPath.starSelected,
                                  width: 14,
                                  height: 14,
                                ),
                              ),
                            )
                          else
                            WidgetSpan(
                              alignment: PlaceholderAlignment.middle,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 6.0),
                                child: SvgPicture.asset(
                                  IconPath.starSelected,
                                  colorFilter: ColorFilter.mode(
                                    mainGrey,
                                    BlendMode.srcIn,
                                  ),
                                  width: 14,
                                  height: 14,
                                ),
                              ),
                            )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
