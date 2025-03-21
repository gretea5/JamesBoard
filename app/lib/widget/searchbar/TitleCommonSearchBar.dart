import 'package:flutter/material.dart';
import 'package:jamesboard/theme/Colors.dart';

class TitleCommonSearchBar extends StatelessWidget {
  const TitleCommonSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "어떤 보드게임을 찾으시나요?",
                hintStyle: TextStyle(
                  color: mainGrey
                ),
                filled: true,
                fillColor: secondaryBlack,
                contentPadding: EdgeInsets.symmetric(vertical: 2),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: Icon(Icons.search, color: mainGrey),
              ),
            ),
          ),
          SizedBox(width: 1),
          TextButton(
            onPressed: () {
              FocusScope.of(context).unfocus();
            },
            child: Text(
              "취소",
              style: TextStyle(color: mainWhite, fontSize: 16, fontFamily: 'PretendardSemiBold'),
            ),
          ),
        ],
      ),
    );
  }
}