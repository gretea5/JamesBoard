import 'package:flutter/material.dart';
import 'package:jamesboard/feature/boardgame/widget/BottomSheetBoardGameDetailDetail.dart';
import 'package:logger/logger.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jamesboard/theme/Colors.dart';

final logger = Logger(
    printer: PrettyPrinter(
  colors: true,
  printEmojis: true,
  printTime: true,
));

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> items = List.generate(20, (index) => 'Item $index');

  void _showGameDetailBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) => BottomSheetBoardGameDetailDetail(
            gameTitle: '클루',
            gameReleaseYear: 1997,
            gameCategories: ['추리', '전략'],
            gameThemes: ['카드게임', '경제', '유머'],
            gameAverageRating: 3.7,
            gameDifficulty: 1,
            gameAge: 15,
            gameMinPlayer: 3,
            gameMaxPlayer: 6,
            gamePlayTime: 100,
            gameDescription:
                '클루에 대한 설명입니다. 클루에 대한 설명입니다. 클루에 대한 설명입니다. 클루에 대한 설명입니다. 클루에 대한 설명입니다. 클루에 대한 설명입니다. '
                '클루에 대한 설명입니다. 클루에 대한 설명입니다. 클루에 대한 설명입니다. 클루에 대한 설명입니다. 클루에 대한 설명입니다. '
                '클루에 대한 설명입니다. 클루에 대한 설명입니다. 클루에 대한 설명입니다. 클루에 대한 설명입니다. 클루에 대한 설명입니다.',
            gamePublisher: 'Roxley',
            gameDesigners: ['Gavan Brown', 'Matt Tolman']));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(

      ),
      backgroundColor: Colors.black, // 배경색 검정으로 설정
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: secondaryBlack,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: mainWhite,
          unselectedItemColor: mainWhite,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/icon_home_unselected.svg',
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(mainWhite, BlendMode.srcIn)),
              activeIcon: SvgPicture.asset('assets/icons/icon_home_selected.svg',
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(mainWhite, BlendMode.srcIn)),
              label: 'home',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/icon_recommend_unselected.svg',
                  width: 24,
                  height: 24,
                  colorFilter: ColorFilter.mode(mainWhite, BlendMode.srcIn)),
              activeIcon: SvgPicture.asset('assets/icons/icon_recommend_selected.svg',
                  width: 24,
                  height: 24,
                  colorFilter: ColorFilter.mode(mainWhite, BlendMode.srcIn)),
              label: 'recommend',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/icon_register_unselected.svg',
                  width: 24,
                  height: 24,
                  colorFilter: ColorFilter.mode(mainWhite, BlendMode.srcIn)),
              label: 'search',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/icon_archive_unselected.svg',
                  width: 24,
                  height: 24,
                  colorFilter: ColorFilter.mode(mainWhite, BlendMode.srcIn)),
              activeIcon: SvgPicture.asset('assets/icons/icon_archive_selected.svg',
                  width: 24,
                  height: 24,
                  colorFilter: ColorFilter.mode(mainWhite, BlendMode.srcIn)),
              label: 'recommend',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/icon_mypage_unselected.svg',
                  width: 24,
                  height: 24,
                  colorFilter: ColorFilter.mode(mainWhite, BlendMode.srcIn)),
              activeIcon: SvgPicture.asset('assets/icons/icon_mypage_selected.svg',
                  width: 24,
                  height: 24,
                  colorFilter: ColorFilter.mode(mainWhite, BlendMode.srcIn)),
              label: 'mypage',
            ),
          ]
      ),
    );
  }
}
