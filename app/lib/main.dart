import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jamesboard/theme/Colors.dart';
import 'package:jamesboard/widget/toolbar/DefaultCommonAppBar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        //         // TRY THIS: Try running your application with "flutter run". You'll see
        //         // the application has a purple toolbar. Then, without quitting the app,
        //         // try changing the seedColor in the colorScheme below to Colors.green
        //         // and then invoke "hot reload" (save your changes or press the "hot
        //         // reload" button in a Flutter-supported IDE, or press "r" if you used
        //         // the command line to start the app).
        //         //
        //         // Notice that the counter didn't reset back to zero; the application
        //         // state is not lost during the reload. To reset the state, use hot
        //         // restart instead.
        //         //
        //         // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> items = List.generate(20, (index) => 'Item $index');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // 배경색 검정으로 설정
      appBar: DefaultCommonAppBar(title: "안녕하세요"),
      body: SizedBox(),
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
          ]),
    );
  }
}
