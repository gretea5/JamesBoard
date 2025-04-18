import 'package:flutter/material.dart';
import 'package:jamesboard/feature/user/screen/MissionRecordScreen.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../constants/FontString.dart';
import '../../datasource/model/response/MyPage/MyPagePlayedGames.dart';
import '../../feature/user/viewmodel/MyPageViewModel.dart';
import '../../theme/Colors.dart';

class ImageCommonMyPageGameCard extends StatelessWidget {
  final List<MyPagePlayedGames> images;
  final bool isLoading;
  final bool isInitialized;

  const ImageCommonMyPageGameCard({
    super.key,
    required this.images,
    required this.isLoading,
    required this.isInitialized,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading || !isInitialized) {
      // Shimmer 로딩 아이템을 보여줌
      return SizedBox();
    }

    if (images.isEmpty) {
      return ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height - kToolbarHeight - 300,
        ),
        child: IntrinsicHeight(
          child: Center(
            child: Text(
              '임무를 기록해주세요.',
              style: TextStyle(
                color: mainWhite,
                fontSize: 18,
                fontFamily: FontString.pretendardSemiBold,
              ),
            ),
          ),
        ),
      );
    }

    // 실제 이미지 목록을 보여줌
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(8.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        childAspectRatio: 1,
      ),
      itemCount: images.length,
      itemBuilder: (context, index) {
        final item = images[index];

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MissionRecordScreen(id: item.gameId),
              ),
            );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: item.gameImage != null
                ? Image.network(
                    item.gameImage!,
                    fit: BoxFit.cover,
                  )
                : Image.asset('assets/image/sample.png', fit: BoxFit.cover),
          ),
        );
      },
    );
  }
}
