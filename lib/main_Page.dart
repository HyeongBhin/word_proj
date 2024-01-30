import 'package:flutter/material.dart';

import 'ChapterSelection_Card.dart';
import 'ChapterSelection_Quiz.dart';
import 'review_page.dart';
import 'Test_Page.dart';
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
        '/word_card': (context) => ChapterSelection_Card(),
        '/word_quiz': (context) => ChapterSelection_Quiz(),
        '/review_page': (context) => ReviewPage(),
        '/test_page': (context) => TestPage(),
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
              child: Text('Word Cards'),
              onPressed: () {
                Navigator.pushNamed(context, '/word_card');
              },
            ),
            ElevatedButton(
              child: Text('Word Quiz'),
              onPressed: () {
                Navigator.pushNamed(context, '/word_quiz');
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
