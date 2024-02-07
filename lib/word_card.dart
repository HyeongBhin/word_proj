// word_card_page.dart
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'FlipCardView.dart';
import 'word_data.dart';
import 'Word.dart';

class WordCardPage extends StatelessWidget {
  final String chapter;

  WordCardPage({required this.chapter});

  @override
  Widget build(BuildContext context) {
    // Provider를 통해 SheetIdProvider 인스턴스를 얻습니다.
    final sheetIdProvider = Provider.of<SheetIdProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('영어 단어장 $chapter'),
      ),
      body: FutureBuilder<Map<String, List<Word>>>(
        // loadDataFromSheets 함수를 올바르게 호출합니다.
        future: WordData.loadDataFromSheets(sheetIdProvider, chapter),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available'));
          } else {
            Map<String, List<Word>> data = snapshot.data!;
            List<Word> words = data[chapter] ?? [];

            // Sort words if needed

            String title = chapter;
            return WordGridView(words: words, title: title);
          }
        },
      ),
    );
  }
}


class WordGridView<T> extends StatelessWidget {
  final List<T> words;
  final String title;

  WordGridView({required this.words, required this.title});

  @override
  Widget build(BuildContext context) {
    // 화면 크기에 따라 crossAxisCount 값을 동적으로 결정합니다.
    int crossAxisCount = 2; // 기본값
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 600) { // 태블릿 크기
      crossAxisCount = 3;
    }
    if (screenWidth > 900) { // PC 크기
      crossAxisCount = 5;
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        ),
        Expanded(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              childAspectRatio: 1 / 0.8,
            ),
            itemCount: words.length,
            itemBuilder: (context, index) {
              final word = words[index];
              // FlipCard 대신 FlipCardView를 사용합니다.
              return FlipCardView(
                word: word,
                frontText: getEword(word), // 단어의 앞면 텍스트
                backText: getMeaning(word), // 단어의 뒷면 텍스트
              );
            },
          ),
        ),
      ],
    );
  }

  String getEword(dynamic word) {
    if (word is Word_1) {
      return word.eword_1;
    } else if (word is Word_2) {
      return word.eword_2;
    } else if (word is Word_3) {
      return word.eword_3;
    } else if (word is Word_4) {
      return word.eword_4;
    } else if (word is Word_5) {
      return word.eword_5;
    }
    return 'Unknown';
  }

  String getMeaning(dynamic word) {
    if (word is Word_1) {
      return word.meaning_1;
    } else if (word is Word_2) {
      return word.meaning_2;
    }else if (word is Word_3) {
      return word.meaning_3;
    }else if (word is Word_4) {
      return word.meaning_4;
    }else if (word is Word_5) {
      return word.meaning_5;
    }
    return 'Unknown';
  }

}
