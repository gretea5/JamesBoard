import 'package:flutter/cupertino.dart';

import '../../../theme/Colors.dart';

class ImageItem extends StatelessWidget {
  final String imageUrl;

  const ImageItem({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double size = (constraints.maxWidth - 16) / 2;

        return Image.asset(
          imageUrl,
          width: size * 0.3,
          height: size * 0.3,
        );
      },
    );
  }
}
