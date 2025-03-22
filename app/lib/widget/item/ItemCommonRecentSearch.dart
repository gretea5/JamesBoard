import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // flutter_svg 패키지 추가
import 'package:jamesboard/theme/Colors.dart';

class ItemCommonRecentSearch extends StatefulWidget {
  final String title;
  final String iconPath;

  const ItemCommonRecentSearch({
    super.key,
    required this.title,
    required this.iconPath
  });

  @override
  State<ItemCommonRecentSearch> createState() => _ItemCommonRecentSearchState();
}

class _ItemCommonRecentSearchState extends State<ItemCommonRecentSearch> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 1),
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: ListTile(
        title: Text(
          widget.title,
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'PretendardSemiBold',
            color: mainWhite
          ),
        ),
        trailing: SvgPicture.asset(
          widget.iconPath, // SVG 체크 아이콘
          width: 18,
          height: 18,
          colorFilter: ColorFilter.mode(mainWhite, BlendMode.srcIn),
        ),
      ),
    );
  }
}
