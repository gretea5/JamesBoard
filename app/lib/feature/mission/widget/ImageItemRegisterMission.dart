import 'package:flutter/cupertino.dart';

import '../../../theme/Colors.dart';

class ImageItemRegisterMission extends StatelessWidget {
  final String imageUrl;

  const ImageItemRegisterMission({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double size = (constraints.maxWidth - 16) / 2;

        return Container(
          width: size * 0.3,
          height: size * 0.3,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage(imageUrl),
                fit: BoxFit.cover,
              )),
        );
      },
    );
  }
}
