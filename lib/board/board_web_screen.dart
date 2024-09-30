import 'package:flutter/material.dart';
import 'board_system.dart';
import 'board_widget.dart';

// 웹, 테블릿 앱에서 실행시 나타나는 화면
class BoardWebScreen extends StatefulWidget {
  const BoardWebScreen({super.key});
  @override
  State<BoardWebScreen> createState() => _BoardWebScreenState();
}

class _BoardWebScreenState extends State<BoardWebScreen> {
  late Size size;
  bool _blackTurn = true; // 차례 확인

  // 이겼거나 항복했을때 실행되는 함수
  void _win() {
    winDialog(context, _blackTurn);
    setState(() {
      _blackTurn = true;
      board = List.generate(15, (_) => List.filled(15, 0));
    });
  }

  @override
  Widget build(BuildContext context) {
    size = getSize(MediaQuery.of(context).size, kToolbarHeight * 2);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: getColor(_blackTurn, false),
        title: Text(
          '${_blackTurn ? '흑' : '백'}돌 차례입니다',
          style: TextStyle(color: getColor(_blackTurn, true)),
        ),
        actions: [
          IconButton(
            onPressed: () {
              _blackTurn = !_blackTurn;
              _win();
            },
            icon: Icon(
              Icons.flag,
              color: getColor(_blackTurn, true),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: getColor(_blackTurn, false),
        height: kToolbarHeight,
      ),
      body: Center(
        child: Container(
          height: size.height - 1, // 사이즈를 -1을 안할경우 오른쪽에 슬라이드바가 생성됨
          width: size.width - 1,
          constraints: const BoxConstraints(
            maxHeight: 700, // 최대 높이 제한
            maxWidth: 700, // 최대 너비 제한
            minHeight: 300, // 최소 높이 제한
            minWidth: 300, // 최소 너비 제한
          ),
          decoration: const BoxDecoration(
            color: Color(0xfff5c283),
            // 외각선을 바둑판 외부에서 표현하기위해 그림자 사용
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                offset: Offset(0, 0), // 그림자의 위치 조정
                blurRadius: 0, // 흐림 정도
                spreadRadius: 1, // 외부로 퍼지는 정도
              ),
            ],
          ),
          child: GridView.builder(
            itemCount: 15 * 15,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 15),
            itemBuilder: (context, index) {
              int row = index ~/ 15;
              int col = index % 15;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    if (board[row][col] == 0) {
                      if (!_blackTurn) {
                        board[row][col] = 1;
                      } else {
                        board[row][col] = 2;
                      }
                      if (checkBoard(row, col)) {
                        _win();
                      } else {
                        _blackTurn = !_blackTurn;
                      }
                    }
                  });
                },
                child: CustomPaint(
                  painter: BoardWidget(),
                  child: stons(row, col, false),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
