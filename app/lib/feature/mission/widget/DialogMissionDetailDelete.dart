import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jamesboard/feature/mission/widget/ButtonMissionDetailDialog.dart';
import 'package:jamesboard/theme/Colors.dart';

import '../../../main.dart';

class DialogMissionDetailDelete extends StatelessWidget {
  final String mainMessage;
  final String subMessage;

  const DialogMissionDetailDelete(
      {super.key, required this.mainMessage, required this.subMessage});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: secondaryBlack,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: mainGold,
            width: 1,
          )),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.90,
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 메인 텍스트
            Text(
              mainMessage,
              style: TextStyle(
                  color: mainWhite,
                  fontSize: 20,
                  fontFamily: 'PretendardSemiBold'),
            ),
            const SizedBox(height: 20),

            // 서브 텍스트
            Text(
              subMessage,
              style: TextStyle(
                  color: mainWhite,
                  fontSize: 16,
                  fontFamily: 'PretendardSemiBold'),
            ),
            const SizedBox(height: 32),

            // 버튼들
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // 취소 버튼
                Expanded(
                    child: ButtonMissionDetailDialog(
                        text: '취소',
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        })),

                const SizedBox(width: 28),

                // 확인 버튼
                Expanded(
                    child: ButtonMissionDetailDialog(
                        text: '확인',
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        })),
              ],
            )
          ],
        ),
      ),
    );
  }
}

Future<void> showDialogMissionDetailDelete(
    BuildContext context, String mainMessage, String subMessage) async {
  bool? result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogMissionDetailDelete(
            mainMessage: mainMessage, subMessage: subMessage);
      });

  if (result == true) {
    // 사용자가 '확인' 선택 시 처리
    logger.d('확인이 눌림');
  } else {
    // 사용자가 '취소' 선택 시 처리
    logger.d('취소가 눌림');
  }
}
