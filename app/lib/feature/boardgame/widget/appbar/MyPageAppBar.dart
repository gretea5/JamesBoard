import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jamesboard/theme/Colors.dart';

class MyPageAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const MyPageAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: mainBlack,
      elevation: 0,
      title: Text(
          title,
          style: TextStyle(
              fontSize: 22,
              color: mainWhite,
              fontFamily: 'PretendardSemiBold'
          )
      ),
      actions: [
        IconButton(
          icon: SvgPicture.asset(
            'assets/image/icon_logout.svg',  // 🔹 SVG 아이콘 적용
            width: 24,  // 아이콘 크기 조정
            height: 24,
            colorFilter: ColorFilter.mode(mainWhite, BlendMode.srcIn), // 🔹 색상 변경
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
