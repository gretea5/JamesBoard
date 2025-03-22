import 'package:flutter/material.dart';
import 'package:jamesboard/theme/Colors.dart';

class ButtonCommonPrimaryBottom extends StatelessWidget {
  final String text;
  const ButtonCommonPrimaryBottom({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // 버튼 클릭 시 동작
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        backgroundColor: secondaryBlack
      ),
      child: SizedBox(
        width: double.infinity, // 너비를 최대한 확장
        height: 50, // 원하는 높이 설정
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: mainWhite,
              fontFamily: 'PretendardSemiBold'
            ),
          )
        ),
      ),
    );
  }
}
