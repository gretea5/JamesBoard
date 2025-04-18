import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jamesboard/constants/AppString.dart';
import 'package:jamesboard/constants/FontString.dart';
import 'package:jamesboard/feature/mission/widget/ButtonMissionDetailDialog.dart';
import 'package:jamesboard/theme/Colors.dart';

import '../../../main.dart';

class DialogMissionDetailDelete extends StatelessWidget {
  final String mainMessage;
  final String subMessage;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const DialogMissionDetailDelete({
    super.key,
    required this.mainMessage,
    required this.subMessage,
    required this.onConfirm,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 배경 처리
        GestureDetector(
          onTap: onCancel,
          child: Container(
            color: Colors.black.withOpacity(0.5),
            width: double.infinity,
            height: double.infinity,
          ),
        ),

        // 다이얼로그
        Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.90,
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: secondaryBlack,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: mainGold,
                width: 1,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 메인 메시지
                Text(
                  mainMessage,
                  style: TextStyle(
                    color: mainWhite,
                    fontSize: 20,
                    fontFamily: FontString.pretendardSemiBold,
                    decoration: TextDecoration.none,
                  ),
                ),
                const SizedBox(height: 20),

                // 서브 메시지
                Text(
                  subMessage,
                  style: TextStyle(
                    color: mainWhite,
                    fontSize: 16,
                    fontFamily: FontString.pretendardSemiBold,
                    decoration: TextDecoration.none,
                  ),
                ),
                const SizedBox(height: 32),

                // 버튼들
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // 취소
                    Expanded(
                      child: ButtonMissionDetailDialog(
                        text: AppString.cancel,
                        onPressed: onCancel,
                      ),
                    ),

                    const SizedBox(width: 20),

                    // 확인
                    Expanded(
                      child: ButtonMissionDetailDialog(
                        text: AppString.confirm,
                        onPressed: onConfirm,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

Future<bool?> showCustomDialogMissionDetailDelete(
    BuildContext context, String mainMessage, String subMessage) {
  return showGeneralDialog<bool>(
    context: context,
    barrierDismissible: true,
    barrierLabel: '',
    barrierColor: Colors.black.withOpacity(0.5),
    pageBuilder: (context, animation, secondaryAnimation) {
      return DialogMissionDetailDelete(
        mainMessage: mainMessage,
        subMessage: subMessage,
        onConfirm: () {
          logger.d(
              'DialogMissionDetailDelete / showCustomDialogMissionDetailDelete : onConfirm() 누름');
          Navigator.of(context).pop(true);
        },
        onCancel: () {
          Navigator.of(context).pop(false);
        },
      );
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: ScaleTransition(
          scale: CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutBack,
          ),
          child: child,
        ),
      );
    },
  );
}
