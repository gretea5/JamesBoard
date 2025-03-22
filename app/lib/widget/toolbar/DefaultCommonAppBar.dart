import 'package:flutter/material.dart';
import 'package:jamesboard/theme/Colors.dart';

class DefaultCommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const DefaultCommonAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: mainBlack,
      elevation: 0,
      title: Text(
        title,
        style: TextStyle(
          color: mainWhite,
          fontFamily: 'PretendardSemiBold'
        )
      ),
      centerTitle: true,
      leading: IconButton(
        icon: Icon(
          Icons.chevron_left,
          color: mainWhite,
        ),
        onPressed: null
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
