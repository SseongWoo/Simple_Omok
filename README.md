# SimpleOmok

## 프로젝트 소개
- 이 프로젝트는 웹, 앱(Aos,iOS)에서 동작하는 간단한 오목 게임 프로젝트입니다.

## 개요
- 프로젝트 : 크로스플랫폼 오목
- 분류 : 개인프로젝트
- 제작기간 : 24.09.28~24.09.30
- 사용기술 : Flutter, Dart
- 사용 IDE : Android Studio
- 사용 플랫폼 : Aos, iOS, web

## 개발환경
- Android Studio Koala | 2024.1.1
- Flutter 3.24.3
- Dart 3.5.3
- Android 14.0, iOS 18

## 프로젝트 구성
### 화면 구성
|모바일_흑차례|모바일_백차례|
|:---:|:---:|
|<img src = "https://github.com/user-attachments/assets/c0e83204-6107-4795-8ea0-1b323c10f1cb" width="300" height="650">|<img src = "https://github.com/user-attachments/assets/105e25ef-3038-4c36-ba51-7b520466f71c" width="300" height="650">|
|모바일_게임종료||
|<img src = "https://github.com/user-attachments/assets/87c387f8-179e-4b9c-b923-b6dc1e182fd4" width="300" height="650">||
|웹_흑차례|웹_백차례|
|<img src = "https://github.com/user-attachments/assets/15e7e3f8-4677-4763-ae98-bb98fcb776a8" width="500" height="500">|<img src = "https://github.com/user-attachments/assets/655c1969-a1d9-4729-ad5a-bae103f08854" width="500" height="500">|
|웹_게임종료|웹_반응형크기조절(최대 700x700, 최소 300x300)|
|<img src = "https://github.com/user-attachments/assets/62f63257-ee5c-496f-9194-34013dad5c72" width="500" height="500">|<img src = "https://github.com/user-attachments/assets/47ab1490-099c-4d7d-9661-5d2bcf8dab5e" width="500" height="500">|

### 디렉토리 구조

```sh
lib
├── board
│   ├── board_screen.dart    // 앱 화면
│   ├── board_system.dart    // 오목 시스템
│   ├── board_web_screen.dart  // 웹 화면
│   └── board_widget.dart  // 바둑판, 바둑돌등의 위젯
└── main.dart
```

