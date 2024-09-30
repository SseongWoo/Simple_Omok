import 'package:flutter/material.dart';
import 'package:omok/board/board_system.dart';

// 바둑판의 칸에 선을 넣는 위젯
class BoardWidget extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2;

    // 가로 중앙 선
    canvas.drawLine(
      Offset(0, size.height / 2), // 시작점
      Offset(size.width, size.height / 2), // 끝점
      paint,
    );

    // 세로 중앙 선
    canvas.drawLine(
      Offset(size.width / 2, 0), // 시작점
      Offset(size.width / 2, size.height), // 끝점
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

// 바둑돌 위젯
Widget stons(int row, int col, bool cursorCheck) {
  Color? stoneColor;
  stoneColor = null;
  int item = board[row][col];
  if (item == 1) {
    stoneColor = Colors.white; // 백돌
  } else if (item == 2) {
    stoneColor = Colors.black; // 흑돌
  }
  return Container(
    decoration: BoxDecoration(
        color: stoneColor,
        shape: BoxShape.circle,
        border: cursorCheck
            ? Border.all(color: Colors.blue, width: 3.0)
            : item != 0
                ? Border.all(color: Colors.black)
                : null),
  );
}

// 조이스틱 위젯
class Controller extends StatefulWidget {
  final Size size;
  final bool black;
  final VoidCallback onUpPressed;
  final VoidCallback onDownPressed;
  final VoidCallback onLeftPressed;
  final VoidCallback onRightPressed;
  final VoidCallback onPlacePressed;
  const Controller({
    super.key,
    required this.size,
    required this.black,
    required this.onUpPressed,
    required this.onDownPressed,
    required this.onLeftPressed,
    required this.onRightPressed,
    required this.onPlacePressed,
  });

  @override
  State<Controller> createState() => _ControllerState();
}

class _ControllerState extends State<Controller> {
  late Size size;
  late Color color; // 사용자의 색상
  late Color colorR; // 상대방의 색상
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    size = widget.size;
    color = widget.black ? Colors.black : Colors.white;
    colorR = widget.black ? Colors.white : Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // 방향키
        SizedBox(
          width: size.width / 2,
          child: Column(
            children: [
              Container(
                height: size.height / 3,
                color: color,
                child: SizedBox(
                  width: size.height / 3,
                  child: IconButton(
                    onPressed: widget.onUpPressed,
                    style: widget.black ? IconButton.styleFrom(overlayColor: Colors.white) : null,
                    icon: Icon(
                      Icons.arrow_drop_up,
                      color: colorR,
                    ),
                  ),
                ),
              ),
              Container(
                height: size.height / 3,
                width: (size.height / 3) * 3,
                color: color,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: size.height / 3,
                      width: size.height / 3,
                      child: IconButton(
                        onPressed: widget.onLeftPressed,
                        style:
                            widget.black ? IconButton.styleFrom(overlayColor: Colors.white) : null,
                        icon: Icon(
                          Icons.arrow_left,
                          color: colorR,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height / 3,
                      width: size.height / 3,
                    ),
                    SizedBox(
                      height: size.height / 3,
                      width: size.height / 3,
                      child: IconButton(
                        onPressed: widget.onRightPressed,
                        style:
                            widget.black ? IconButton.styleFrom(overlayColor: Colors.white) : null,
                        icon: Icon(
                          Icons.arrow_right,
                          color: colorR,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: size.height / 3,
                color: color,
                child: SizedBox(
                  width: size.height / 3,
                  child: IconButton(
                    onPressed: widget.onDownPressed,
                    style: widget.black ? IconButton.styleFrom(overlayColor: Colors.white) : null,
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: colorR,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        // 여백
        SizedBox(
          width: size.width / 10,
        ),
        // 착수 버튼
        SizedBox(
          width: size.height / 2,
          height: size.height / 2,
          child: ElevatedButton(
            onPressed: widget.onPlacePressed,
            style: ElevatedButton.styleFrom(
                backgroundColor: color, overlayColor: widget.black ? Colors.white : null),
            child: Text(
              '착수',
              style: TextStyle(color: colorR, fontSize: size.height / 10),
            ),
          ),
        )
      ],
    );
  }
}

// 이기거나 항복했을때 나타나는 다이얼로그
void winDialog(BuildContext context, bool blackWin) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('게임 종료'),
        content: Text('${blackWin ? '흑' : '백'}돌이 이겼습니다!'),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('확인'))
        ],
      );
    },
  );
}
