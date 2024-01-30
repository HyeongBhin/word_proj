import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'ChapterSelection_Card.dart';
import 'ChapterSelection_Quiz.dart';
import 'Login_Page.dart';
import 'firebase_options.dart';
import 'review_page.dart';
import 'Test_Page.dart';
import 'main_Page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyFirebaseApp());
}

class MyFirebaseApp extends StatelessWidget {
  const MyFirebaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
      routes: {
        '/word_login': (context) => LoginPage(),
        '/word_main': (context) => MainPage(),
        '/word_card': (context) => ChapterSelection_Card(),
        '/word_quiz': (context) => ChapterSelection_Quiz(),
        '/review_page': (context) => ReviewPage(),
        '/Test_page': (context) => TestPage(),
        // 추가로 필요한 경로와 위젯을 여기에 매핑할 수 있습니다.
      },
    );
  }
}
