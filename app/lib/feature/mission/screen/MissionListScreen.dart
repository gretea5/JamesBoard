import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jamesboard/feature/mission/widget/ImageItemMissionList.dart';
import 'package:jamesboard/theme/Colors.dart';

class MissionListScreen extends StatelessWidget {
  final String title;
  final List<String> imageUrls = [
    'assets/image/mission1.png',
    'assets/image/mission2.png',
    'assets/image/mission3.png',
    'assets/image/mission4.png',
    'assets/image/mission5.png',
    'assets/image/mission6.png',
    'assets/image/mission7.png',
    'assets/image/mission8.png',
    'assets/image/mission1.png',
    'assets/image/mission2.png',
    'assets/image/mission3.png',
    'assets/image/mission4.png',
    'assets/image/mission5.png',
    'assets/image/mission6.png',
    'assets/image/mission7.png',
    'assets/image/mission8.png',
    'assets/image/mission1.png',
    'assets/image/mission2.png',
    'assets/image/mission3.png',
    'assets/image/mission4.png',
    'assets/image/mission5.png',
    'assets/image/mission6.png',
    'assets/image/mission7.png',
    'assets/image/mission8.png',
  ];

  MissionListScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 2.0,
          mainAxisSpacing: 2.0,
        ),
        itemCount: imageUrls.length,
        itemBuilder: (context, index) {
          return ImageItemMissionList(imageUrl: imageUrls[index]);
        },
      ),
    );
  }
}
