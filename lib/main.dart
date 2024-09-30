import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:omok/board/board_web_screen.dart';
import 'board/board_screen.dart';
import 'package:flutter/foundation.dart';

void main() async {
  // 세로모드로 고정하기위해 설정하는 코드
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // 웹, 테블릿에서 실행하면 BoardWebScreen으로 앱에서 실행하면 BoardScreen의 화면을 보여줌
      home: kIsWeb || MediaQuery.of(context).size.shortestSide >= 600
          ? const BoardWebScreen()
          : const BoardScreen(),
    );
  }
}
