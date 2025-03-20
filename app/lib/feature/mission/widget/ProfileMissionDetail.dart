import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jamesboard/theme/Colors.dart';

class ProfileMissionDetail extends StatelessWidget {
  final String imageUrl;
  final String userName;

  const ProfileMissionDetail(
      {super.key, required this.imageUrl, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            // 프로필 사진
            CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage(imageUrl),
            ),
            SizedBox(width: 12),

            // 사용자 이름
            Text(
              userName,
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'PretendardMedium',
                  color: mainWhite),
            )
          ],
        ),

        // 더보기
        GestureDetector(
          onTap: () => {_onMorePressed(context)},
          child: SvgPicture.asset(
            'assets/image/ic_more.svg',
            width: 24,
            height: 24,
            color: mainWhite,
          ),
        ),
      ],
    );
  }

  void _onMorePressed(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.2,
          decoration: BoxDecoration(
            color: secondaryBlack,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 수정 버튼
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: mainGrey,
                      width: 1.0,
                    ),
                  ),
                ),
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: secondaryBlack,
                    padding: const EdgeInsets.symmetric(vertical: 24),
                  ),
                  child: Text(
                    '수정',
                    style: TextStyle(
                      color: mainWhite,
                      fontSize: 20,
                      fontFamily: 'PretendardBold',
                    ),
                  ),
                ),
              ),

              // 삭제 버튼
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: secondaryBlack,
                    padding: const EdgeInsets.symmetric(vertical: 24),
                  ),
                  child: Text(
                    '삭제',
                    style: TextStyle(
                      color: mainWhite,
                      fontSize: 20,
                      fontFamily: 'PretendardBold',
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
