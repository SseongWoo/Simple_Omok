import 'dart:math';
import 'package:flutter/material.dart';
import 'package:omok/board/board_system.dart';
import 'package:omok/board/board_widget.dart';

class BoardScreen extends StatefulWidget {
  const BoardScreen({super.key});

  @override
  State<BoardScreen> createState() => _BoardScreenState();
}

class _BoardScreenState extends State<BoardScreen> {
  bool _blackTurn = true; // 차례확인
  int cursorRow = 7; // 현재 커서 위치
  int cursorCol = 7; // 현재 커서 위치

  // 위 키를 눌렀을때 실행
  void _up() {
    setState(() {
      if (cursorRow > 0) {
        cursorRow--;
      } else {
        cursorRow = 14;
      }
    });
  }

  // 아래키를 눌렀을때 실행
  void _down() {
    setState(() {
      if (cursorRow < 14) {
        cursorRow++;
      } else {
        cursorRow = 0;
      }
    });
  }

  // 왼쪽키를 눌렀을때 실행
  void _left() {
    setState(() {
      if (cursorCol > 0) {
        cursorCol--;
      } else {
        cursorCol = 14;
      }
    });
  }

  // 오른쪽키를 눌렀을때 실행
  void _right() {
    setState(() {
      if (cursorCol < 14) {
        cursorCol++;
      } else {
        cursorCol = 0;
      }
    });
  }

  // 착수 버튼을 눌렀을때 실행
  void _pressed() {
    setState(() {
      if (board[cursorRow][cursorCol] == 0) {
        if (!_blackTurn) {
          board[cursorRow][cursorCol] = 1;
        } else {
          board[cursorRow][cursorCol] = 2;
        }
        if (checkBoard(cursorRow, cursorCol)) {
          _win();
        }
        _blackTurn = !_blackTurn;
      }

      // 커서 위치 초기화
      cursorCol = 7;
      cursorRow = 7;
    });
  }

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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xfff5c283),
      body: Column(
        children: [
          SizedBox(
            height: size.height / 20,
          ),
          Container(
            height: size.height / 6,
            width: size.width,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(50)),
              color: _blackTurn ? Colors.grey : Colors.grey[400],
            ),

            // 상대방 조이스틱
            child: !_blackTurn
                ? Transform.rotate(
                    angle: pi, // 180도 회전
                    child: Controller(
                        // 반대 기준으로 위 아래 오른쪽 왼쪽을 설정
                        size: Size(size.width, size.height / 6),
                        black: false,
                        onUpPressed: _down,
                        onDownPressed: _up,
                        onLeftPressed: _right,
                        onRightPressed: _left,
                        onPlacePressed: _pressed),
                  )
                : Center(
                    child: SizedBox(
                      height: size.height / 12,
                      width: size.width / 2,
                      child: ElevatedButton(
                        onPressed: () {
                          _blackTurn = !_blackTurn;
                          _win();
                        },
                        child: const Text(
                          '기권하기',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
          ),

          // 바둑판
          Expanded(
            child: GridView.builder(
              itemCount: 15 * 15,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 15),
              itemBuilder: (context, index) {
                int row = index ~/ 15;
                int col = index % 15;
                bool cursorCheck;
                if (cursorRow == row && cursorCol == col) {
                  cursorCheck = true;
                } else {
                  cursorCheck = false;
                }
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
                        }
                        _blackTurn = !_blackTurn;
                      }
                    });
                  },
                  child: CustomPaint(
                    painter: BoardWidget(),
                    child: stons(row, col, cursorCheck),
                  ),
                );
              },
            ),
          ),

          // 내 조이스틱
          Container(
            height: size.height / 6,
            width: size.width,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(50)),
              color: _blackTurn ? Colors.grey : Colors.grey[400],
            ),
            child: _blackTurn
                ? Controller(
                    size: Size(size.width, size.height / 6),
                    black: true,
                    onUpPressed: _up,
                    onDownPressed: _down,
                    onLeftPressed: _left,
                    onRightPressed: _right,
                    onPlacePressed: _pressed,
                  )
                : Transform.rotate(
                    angle: pi,
                    child: Center(
                      child: SizedBox(
                        height: size.height / 12,
                        width: size.width / 2,
                        child: ElevatedButton(
                          onPressed: () {
                            _blackTurn = !_blackTurn;
                            _win();
                          },
                          child: const Text(
                            '기권하기',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ),
          ),
          SizedBox(
            height: size.height / 20,
          ),
        ],
      ),
    );
  }
}
