import 'package:flutter/material.dart';
import 'package:jamesboard/theme/Colors.dart';

class EditBoxRegisterMissionBoardGameCount extends StatefulWidget {
  const EditBoxRegisterMissionBoardGameCount({super.key});

  @override
  State<EditBoxRegisterMissionBoardGameCount> createState() =>
      _CustomInputBoxState();
}

class _CustomInputBoxState extends State<EditBoxRegisterMissionBoardGameCount> {
  final TextEditingController _controller = TextEditingController();
  bool _hasInput = false;

  void initState() {
    super.initState();

    _controller.addListener(() {
      setState(() {
        _hasInput = _controller.text.isNotEmpty;
      });
    });
  }

  // 메모리 누수 방지.
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: secondaryBlack,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: _controller,
        keyboardType: TextInputType.number,
        style: TextStyle(
          color: _hasInput ? mainWhite : mainGrey,
          fontSize: 16,
          fontFamily: 'PretendardMedium',
        ),
        decoration: InputDecoration(
            hintText: '판수 입력',
            hintStyle: TextStyle(
                color: mainGrey, fontSize: 16, fontFamily: 'PretendardMedium'),
            border: InputBorder.none,
            isDense: true,
            contentPadding: EdgeInsets.zero),
      ),
    );
  }
}
