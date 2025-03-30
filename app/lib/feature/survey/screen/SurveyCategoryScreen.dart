import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jamesboard/constants/FontString.dart';
import 'package:jamesboard/feature/survey/screen/SurveyBoardGameScreen.dart';
import 'package:jamesboard/feature/survey/widget/ImageSurveyCategory.dart';
import 'package:jamesboard/theme/Colors.dart';
import 'package:jamesboard/util/dummy/AppDummyData.dart';
import 'package:jamesboard/widget/button/ButtonCommonPrimaryBottom.dart';

import '../../../main.dart';

class SurveyCategoryScreen extends StatefulWidget {
  const SurveyCategoryScreen({super.key});

  @override
  State<SurveyCategoryScreen> createState() => _SurveyCategoryScreenState();
}

class _SurveyCategoryScreenState extends State<SurveyCategoryScreen> {
  String? selectedId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBlack,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '마음에 드는 임무 \n',
                      style: TextStyle(
                        color: mainWhite,
                        fontFamily: FontString.pretendardSemiBold,
                        fontSize: 32,
                      ),
                    ),
                    TextSpan(
                      text: '카테고리',
                      style: TextStyle(
                        color: mainGold, // 강조 색상!
                        fontFamily: FontString.pretendardSemiBold,
                        fontSize: 32,
                      ),
                    ),
                    TextSpan(
                      text: '를 선택하세요.',
                      style: TextStyle(
                        color: mainWhite,
                        fontFamily: FontString.pretendardSemiBold,
                        fontSize: 32,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '선호 장르에 맞는 최적의 보드게임을 추천해 드리겠습니다.',
                style: TextStyle(
                  color: mainGrey,
                  fontFamily: FontString.pretendardSemiBold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 32),
              ImageSurveyCategory(
                images: AppDummyData.surveyImages,
                onImageTap: (id) {
                  setState(() {
                    selectedId = id;
                  });
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 32,
        ),
        child: ButtonCommonPrimaryBottom(
          text: '선택',
          onPressed: selectedId != null
              ? () {
                  logger.d('selectedId : $selectedId');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SurveyBoardGameScreen(
                        selectedBoardGameId: selectedId!,
                      ),
                    ),
                  );
                }
              : null,
        ),
      ),
    );
  }
}
