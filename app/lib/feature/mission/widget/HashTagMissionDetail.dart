import 'package:flutter/cupertino.dart';
import 'package:jamesboard/theme/Colors.dart';

class HashTagMissionDetail extends StatelessWidget {
  final String info;

  const HashTagMissionDetail({super.key, required this.info});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '#$info',
          style: TextStyle(
              color: mainGold, fontFamily: 'PretendardMedium', fontSize: 16),
        )
      ],
    );
  }
}
