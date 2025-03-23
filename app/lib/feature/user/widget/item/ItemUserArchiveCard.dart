import 'package:flutter/material.dart';
import 'package:jamesboard/theme/Colors.dart';
import 'package:jamesboard/widget/button/ButtonCommonGameTag.dart';

class ItemUserArchiveCard extends StatelessWidget {
  final String imageUrl;
  final String content;
  final String tag;

  const ItemUserArchiveCard({
    super.key,
    required this.imageUrl,
    required this.content,
    required this.tag
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: mainGrey,
            width: 1
          )
        ),
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              child: Image.asset(
                'assets/image/item_archieve_photo.jpg',
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text(
                    'This is a description for the card. Here you can put some content that explains more about the card.',
                    style: TextStyle(fontSize: 16, color: mainWhite, fontFamily: 'PretendardMedium'),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ButtonCommonGameTag(text: "3시간 40분")
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
