import 'package:flutter/material.dart';
import 'package:test_proj/SheetSelection_Page.dart';

import 'SheetSelection_Page.dart';
import 'Selection_Page.dart';
import 'ChapterSelection_Card.dart';
import 'ChapterSelection_Quiz.dart';
import 'review_page.dart';
import 'Login_Page.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Word Study App',
      initialRoute: '/word_main',
      routes: {
        '/word_login': (context) => LoginPage(),
        '/word_main': (context) => MainPage(),
        '/sheet_select' : (context) => SheetSelectionPage(),
        '/select_list' : (context) => SelectPage(),
        '/word_card': (context) => ChapterSelection_Card(),
        '/word_quiz': (context) => ChapterSelection_Quiz(),
        '/review_page': (context) => ReviewPage(),
      },
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: Text('Select Exam'),
              onPressed: () {
                Navigator.pushNamed(context, '/sheet_select');
              },
            ),
            ElevatedButton(
              child: Text('Review Quiz Results'),
              onPressed: () {
                Navigator.pushNamed(context, '/review_page');
              },
            ),
            ElevatedButton(
              child: Text('Test Page'),
              onPressed: () {
                Navigator.pushNamed(context, '/Test_page');
              },
            ),
          ],
        ),
      ),
    );
  }
}
