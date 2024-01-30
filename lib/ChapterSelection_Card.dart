import 'package:flutter/material.dart';

import 'word_card.dart';

class ChapterSelection_Card extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('문제 번호를 고르세요'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WordCardPage(chapter: 'Chapter1')),
                );
              },
              child: Text('Chapter 1'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WordCardPage(chapter: 'Chapter2')),
                );
              },
              child: Text('Chapter 2'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WordCardPage(chapter: 'Chapter3')),
                );
              },
              child: Text('Chapter 3'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WordCardPage(chapter: 'Chapter4')),
                );
              },
              child: Text('Chapter 4'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WordCardPage(chapter: 'Chapter5')),
                );
              },
              child: Text('Chapter 5'),
            ),
          ],
        ),
      ),
    );
  }
}
