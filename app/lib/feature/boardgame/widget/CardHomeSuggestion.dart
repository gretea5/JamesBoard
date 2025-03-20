import 'package:flutter/material.dart';
import 'package:jamesboard/theme/Colors.dart';

class CardHomeSuggestion extends StatefulWidget {
  final List<Map<String, String>> images; // {id: imageUrl}
  final Function(String id) onImageTap; // 클릭 시 수행할 작업

  const CardHomeSuggestion({super.key, required this.images, required this.onImageTap});

  @override
  _CardHomeSuggestionState createState() => _CardHomeSuggestionState();
}

class _CardHomeSuggestionState extends State<CardHomeSuggestion> {
  late PageController _pageController;
  late int _currentPage;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _currentPage = 0;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double width = constraints.maxWidth; // 부모의 최대 너비
        double height = width * (4 / 3); // 3:4 비율 적용

        return Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              itemCount: null, // 무한 스크롤을 위해 itemCount를 제한하지 않음
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index % widget.images.length; // 무한 스크롤처럼 보이게
                });
              },
              itemBuilder: (context, index) {
                final image = widget.images[index % widget.images.length]; // index를 순환
                final imageUrl = image['url']!;
                final id = image['id']!;

                return GestureDetector(
                  onTap: () => widget.onImageTap(id),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4.0),
                    child: Image.network(
                      imageUrl,
                      width: width,
                      height: height,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
            Positioned(
              bottom: 12,
              right: 12,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10), // 텍스트 주위에 패딩 추가
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5), // 배경색과 투명도 추가
                  borderRadius: BorderRadius.circular(30), // 배경의 둥근 모서리
                ),
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '${_currentPage + 1}', // 첫 번째 부분
                        style: TextStyle(
                          color: mainGold, // ${_currentPage + 1} 부분 색상
                          fontSize: 16,
                          fontFamily: 'PretendardBold',
                        ),
                      ),
                      TextSpan(
                        text: ' / ${widget.images.length}', // 두 번째 부분
                        style: TextStyle(
                          color: mainWhite, // 나머지 부분 색상
                          fontSize: 16,
                          fontFamily: 'PretendardBold',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
