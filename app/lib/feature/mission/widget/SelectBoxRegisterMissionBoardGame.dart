import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jamesboard/theme/Colors.dart';

class SelectBoxRegisterMissionBoardGame extends StatefulWidget {
  const SelectBoxRegisterMissionBoardGame({super.key});

  @override
  State<SelectBoxRegisterMissionBoardGame> createState() =>
      _SelectBoxRegisterMissionBoardGameState();
}

class _SelectBoxRegisterMissionBoardGameState
    extends State<SelectBoxRegisterMissionBoardGame> {
  String? _selectedGame;

  // 임시로 상태 변경하는 메서드
  void _handleSelectGame() async {
    String selectedGame =
        await Future.delayed(const Duration(milliseconds: 500), () => '클루');

    setState(() {
      _selectedGame = selectedGame;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleSelectGame,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
            color: secondaryBlack, borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _selectedGame ?? '보드게임 선택',
              style: TextStyle(
                  color: _selectedGame != null ? mainWhite : mainGrey,
                  fontSize: 16,
                  fontFamily: 'PretendardMedium'),
            ),
            SvgPicture.asset(
              'assets/image/ic_arrow_right.svg',
              width: 24,
              height: 24,
              color: mainGrey,
            ),
          ],
        ),
      ),
    );
  }
}
