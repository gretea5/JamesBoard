import 'package:flutter/material.dart';
import 'package:jamesboard/feature/boardgame/widget/BottomSheetBoardGameDetailDetail.dart';
import 'package:jamesboard/feature/boardgame/widget/RatingBarBoardGameDetailReview.dart';
import 'package:jamesboard/feature/boardgame/widget/RatingBoardGameDetail.dart';
import 'package:logger/logger.dart';

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
  // int _counter = 0;
  //
  // void _incrementCounter() {
  //   setState(() {
  //     _counter++;
  //   });
  // }

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            RatingBoardGameDetail(rating: 3.7),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showGameDetailBottomSheet(context),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
