import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'SheetSelection_Page.dart';
import 'Selection_Page.dart';
import 'ChapterSelection_Card.dart';
import 'ChapterSelection_Quiz.dart';
import 'Login_Page.dart';
import 'firebase_options.dart';
import 'review_page.dart';
import 'main_Page.dart';
import 'word_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SheetIdProvider()),
      ],
      child: MaterialApp(
        home: LoginPage(),
        routes: {
          '/word_login': (context) => LoginPage(),
          '/word_main': (context) => MainPage(),
          '/sheet_select': (context) => SheetSelectionPage(),
          '/select_list': (context) => SelectPage(),
          '/word_card': (context) => ChapterSelection_Card(),
          '/word_quiz': (context) => ChapterSelection_Quiz(),
          '/review_page': (context) => ReviewPage(),
          // 추가로 필요한 경로와 위젯을 여기에 매핑할 수 있습니다.
        },
      ),
    );
  }
}