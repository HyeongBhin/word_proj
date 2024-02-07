import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'word_data.dart';
import 'word_quiz.dart';

class ChapterSelection_Quiz extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('챕터를 고르세요'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // 챕터 1 선택 시 QuizPage에 WordData.loadDataFromSheets('sheet1') 전달
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuizPage(
                      Chapter: 'Chapter1',
                      sheetIdProvider: Provider.of<SheetIdProvider>(context, listen: false), // SheetIdProvider 인스턴스 전달
                    ),
                  ),
                );
              },
              child: Text('Chapter 1'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // 챕터 2 선택 시 QuizPage에 WordData.loadDataFromSheets('sheet2') 전달
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuizPage(
                      Chapter: 'Chapter2',
                      sheetIdProvider: Provider.of<SheetIdProvider>(context, listen: false), // SheetIdProvider 인스턴스 전달
                    ),
                  ),
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
                    builder: (context) => QuizPage(
                      Chapter: 'Chapter3',
                      sheetIdProvider: Provider.of<SheetIdProvider>(context, listen: false), // SheetIdProvider 인스턴스 전달
                    ),
                  ),
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
                    builder: (context) => QuizPage(
                      Chapter: 'Chapter4',
                      sheetIdProvider: Provider.of<SheetIdProvider>(context, listen: false), // SheetIdProvider 인스턴스 전달
                    ),
                  ),
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
                    builder: (context) => QuizPage(
                      Chapter: 'Chapter5',
                      sheetIdProvider: Provider.of<SheetIdProvider>(context, listen: false), // SheetIdProvider 인스턴스 전달
                    ),
                  ),
                );
              },
              child: Text('Chapter 5'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuizPage(
                      Chapter: 'AllWords',
                      sheetIdProvider: Provider.of<SheetIdProvider>(context, listen: false), // SheetIdProvider 인스턴스 전달
                    ),
                  ),
                );
              },
              child: Text('AllWords'),
            ),
          ],
        ),
      ),
    );
  }
}
