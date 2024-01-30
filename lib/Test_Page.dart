import 'package:flutter/material.dart';

import 'word_data.dart'; // WordData 클래스를 포함한 파일을 임포트합니다.
import 'Word.dart';

class TestPage extends StatelessWidget {
  final String sheetName = '시트 이름'; // Modify this to the appropriate sheet name

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Sheets Data Test'),
      ),
      body: FutureBuilder<Map<String, List<Word>>>(
        future: WordData.loadDataFromSheets(sheetName),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data found'));
          } else {
            Map<String, List<Word>> data = snapshot.data!;
            List<Word> wordsSheet1 = data['Chapter1'] ?? [];
            List<Word> wordsSheet2 = data['Chapter2'] ?? []; // Modify this for the second sheet

            // Sort wordsSheet1 and wordsSheet2 if needed

            return ListView(
              children: [
                ExpansionTile(
                  title: Text('Chapter 1 Words'),
                  children: wordsSheet1
                      .map((word) => ListTile(
                    title: Text(word.eword),
                    subtitle: Text(word.meaning),
                  ))
                      .toList(),
                ),
                ExpansionTile(
                  title: Text('Chapter 2 Words'),
                  children: wordsSheet2
                      .map((word) => ListTile(
                    title: Text(word.eword),
                    subtitle: Text(word.meaning),
                  ))
                      .toList(),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}



