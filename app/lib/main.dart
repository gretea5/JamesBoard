import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jamesboard/widget/toolbar/DefaultCommonAppBar.dart';
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
  WidgetsFlutterBinding.ensureInitialized();

  // 앱 전체에서 세로 모드만 허용
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(MyApp());
  });

  // runApp(MyApp());
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultCommonAppBar(title: "Q"),
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
              icon: SvgPicture.asset('assets/image/icon_home_unselected.svg',
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(mainWhite, BlendMode.srcIn)),
              activeIcon: SvgPicture.asset('assets/image/icon_home_selected.svg',
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(mainWhite, BlendMode.srcIn)),
              label: 'home',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/image/icon_recommend_unselected.svg',
                  width: 24,
                  height: 24,
                  colorFilter: ColorFilter.mode(mainWhite, BlendMode.srcIn)),
              activeIcon: SvgPicture.asset('assets/image/icon_recommend_selected.svg',
                  width: 24,
                  height: 24,
                  colorFilter: ColorFilter.mode(mainWhite, BlendMode.srcIn)),
              label: 'recommend',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/image/icon_register_unselected.svg',
                  width: 24,
                  height: 24,
                  colorFilter: ColorFilter.mode(mainWhite, BlendMode.srcIn)),
              label: 'search',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/image/icon_archive_unselected.svg',
                  width: 24,
                  height: 24,
                  colorFilter: ColorFilter.mode(mainWhite, BlendMode.srcIn)),
              activeIcon: SvgPicture.asset('assets/image/icon_archive_selected.svg',
                  width: 24,
                  height: 24,
                  colorFilter: ColorFilter.mode(mainWhite, BlendMode.srcIn)),
              label: 'recommend',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/image/icon_mypage_unselected.svg',
                  width: 24,
                  height: 24,
                  colorFilter: ColorFilter.mode(mainWhite, BlendMode.srcIn)),
              activeIcon: SvgPicture.asset('assets/image/icon_mypage_selected.svg',
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
