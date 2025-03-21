import 'package:flutter/material.dart';
import 'package:jamesboard/theme/Colors.dart';

class ButtonCommonGameTag extends StatelessWidget {
  final String text;
  const ButtonCommonGameTag({
    super.key,
    required this.text
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        color: secondaryBlack, // 배경색
        borderRadius: BorderRadius.circular(4), // 둥근 모서리
      ),
      child: Text(
        text,
        style: TextStyle(
          color: mainGold, // 텍스트 색상
          fontSize: 16, // 텍스트 크기
          fontFamily: 'PretendardSemiBold',
          backgroundColor: secondaryBlack, // 배경색
        ),
      ),
    );
  }
}