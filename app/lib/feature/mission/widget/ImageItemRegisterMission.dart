import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../theme/Colors.dart';

class ImageItemRegisterMission extends StatelessWidget {
  final String imageUrl;
  final VoidCallback onRemove;

  const ImageItemRegisterMission({
    super.key,
    required this.imageUrl,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Container(
          width: 150, // 고정 크기 설정
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: _getImageProvider(imageUrl), // FileImage 지원 추가
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: -6,
          right: -6,
          child: GestureDetector(
            onTap: onRemove,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: mainBlack.withOpacity(0.7),
              ),
              child: const Icon(
                Icons.close,
                color: mainGold,
                size: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // 파일인지 에셋인지 구분해서 이미지 반환
  ImageProvider _getImageProvider(String imageUrl) {
    if (imageUrl.startsWith('/')) {
      return FileImage(File(imageUrl));
    } else {
      return AssetImage(imageUrl);
    }
  }
}
