import 'package:flutter/cupertino.dart';
import 'package:jamesboard/constants/FontString.dart';
import 'package:jamesboard/theme/Colors.dart';

class HashTagMissionDetail extends StatelessWidget {
  final String info;

  const HashTagMissionDetail({super.key, required this.info});

  @override
  Widget build(BuildContext context) {
    return Text(
      '#$info',
      style: TextStyle(
          color: mainGold,
          fontFamily: FontString.pretendardMedium,
          fontSize: 16),
      overflow: TextOverflow.visible,
      softWrap: true,
      maxLines: null,
    );
  }
}
