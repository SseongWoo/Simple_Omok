import 'package:flutter/material.dart';

List<List<int>> board = List.generate(15, (_) => List.filled(15, 0)); // 배열을 15*15로 초기화
int boardSize = 15; // 오목판 크기

// 오목이 성공했는지 체크하는 함수
bool checkBoard(int row, int col) {
  if (checkRow(row, col) == 5 ||
      checkCol(row, col) == 5 ||
      checkDiagonalA(row, col) == 5 ||
      checkDiagonalB(row, col) == 5) {
    return true;
  }
  return false;
}

// 세로줄에서 오목이 되었는지 체크하는 함수
int checkRow(int row, int col) {
  int stonCountRow = 1; // 놓은 돌을 포함한 개수
  int playerStone = board[row][col]; // 현재 놓은 돌의 색

  // 왼쪽 방향 체크
  for (int startPointRow = row - 1; startPointRow >= 0; startPointRow--) {
    if (board[startPointRow][col] == playerStone) {
      stonCountRow++;
    } else {
      break;
    }
  }

  // 오른쪽 방향 체크
  for (int startPointRow = row + 1; startPointRow < boardSize; startPointRow++) {
    if (board[startPointRow][col] == playerStone) {
      stonCountRow++;
    } else {
      break;
    }
  }
  return stonCountRow; // 연속된 돌의 갯수 리턴
}

// 가로줄에서 오목이 되었는지 체크하는 함수
int checkCol(int row, int col) {
  int stonCountCol = 1; // 놓은 돌을 포함한 개수
  int playerStone = board[row][col]; // 현재 놓은 돌의 색

  // 위쪽 방향 체크
  for (int startPointCol = col - 1; startPointCol >= 0; startPointCol--) {
    if (board[row][startPointCol] == playerStone) {
      stonCountCol++;
    } else {
      break;
    }
  }

  // 아래쪽 방향 체크
  for (int startPointCol = col + 1; startPointCol < boardSize; startPointCol++) {
    if (board[row][startPointCol] == playerStone) {
      stonCountCol++;
    } else {
      break;
    }
  }
  return stonCountCol; // 연속된 돌의 갯수 리턴
}

// 대각선에서 오목이 되었는지 체크하는 함수1
int checkDiagonalA(int row, int col) {
  int stonCountDiagona = 1; // 놓은 돌을 포함한 개수
  int playerStone = board[row][col]; // 현재 놓은 돌의 색

  // 왼쪽 상단 대각선 체크
  for (int r = row - 1, c = col - 1; r >= 0 && c >= 0; r--, c--) {
    if (board[r][c] == playerStone) {
      stonCountDiagona++;
    } else {
      break;
    }
  }

  // 오른쪽 하단 대각선 체크
  for (int r = row + 1, c = col + 1; r < boardSize && c < boardSize; r++, c++) {
    if (board[r][c] == playerStone) {
      stonCountDiagona++;
    } else {
      break;
    }
  }
  return stonCountDiagona; // 연속된 돌의 갯수 리턴
}

// 대각선에서 오목이 되었는지 체크하는 함수2
int checkDiagonalB(int row, int col) {
  int stonCountDiagona = 1; // 놓은 돌을 포함한 개수
  int playerStone = board[row][col]; // 현재 놓은 돌의 색 (흑돌 또는 백돌)

  // 왼쪽 하단 대각선 체크
  for (int r = row + 1, c = col - 1; r < boardSize && c >= 0; r++, c--) {
    if (board[r][c] == playerStone) {
      stonCountDiagona++;
    } else {
      break;
    }
  }

  // 오른쪽 상단 대각선 체크
  for (int r = row - 1, c = col + 1; r >= 0 && c < boardSize; r--, c++) {
    if (board[r][c] == playerStone) {
      stonCountDiagona++;
    } else {
      break;
    }
  }
  return stonCountDiagona; // 연속된 돌의 갯수 리턴
}

// 웹이나 테블릿에서 바둑판의 크기를 조절하기 위한 함수
// 작은쪽을 기준으로 높이 너비가 정해짐
Size getSize(Size size, double toolbar) {
  if (size.height > size.width) {
    return Size(size.width, size.width);
  } else {
    return Size(size.height - toolbar, size.height - toolbar);
  }
}

// 색을 리턴하는 함수, 검정일때 정방향일경우 검정, 역방향일경우 흰색 반환
Color getColor(bool blackTurn, bool reverse) {
  return (blackTurn ^ reverse) ? Colors.black : Colors.white;
}
