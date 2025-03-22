import 'package:flutter/material.dart';
import 'package:jamesboard/theme/Colors.dart';

class ItemCommonGameRank extends StatelessWidget {
  const ItemCommonGameRank({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 1),
      decoration: BoxDecoration(
        color: secondaryBlack,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Stack(
        clipBehavior: Clip.none, // Stack 내에서의 크기 초과를 허용
        children: [
          ListTile(
            leading: ClipOval( // ClipOval을 이용해 원형으로 만듦
              child: Image.asset(
                'assets/image/bang.png',
                width: 50,
                height: 50,
                fit: BoxFit.cover, // 이미지 비율 유지
              ),
            ),
            title: Text(
              "부루마블",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: mainWhite, // mainWhite 색상 적용
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.access_time),
                SizedBox(width: 8),
                Text(
                  "35분",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: mainWhite, // mainWhite 색상 적용
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            bottom: -20,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // 테두리 색상을 주는 텍스트
                Text(
                  '100',
                  style: TextStyle(
                    fontSize: 40,
                    fontFamily: 'PretendardSemiBold',
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 3
                      ..color = mainGold
                  ),
                ),
                // 안쪽 텍스트 색상
                Text(
                  '100',
                  style: TextStyle(
                    fontSize: 40,
                    fontFamily: 'PretendardSemiBold',
                    color: mainRed, // 텍스트 색상
                  ),
                ),
              ]
            ),
          ),
        ],
      ),
    );
  }
}