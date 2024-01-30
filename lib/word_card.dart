// word_card_page.dart
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

import 'word_data.dart';
import 'Word.dart';

class WordCardPage extends StatelessWidget {
  final String chapter;

  WordCardPage({required this.chapter});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Word Cards '),
      ),
      body: FutureBuilder<Map<String, List<Word>>>(
        future: WordData.loadDataFromSheets(chapter),
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
              crossAxisCount: 4, // 한 줄에 4개의 카드가 들어가도록 설정
              childAspectRatio: 1 / 1.1,
            ),
            itemCount: words.length,
            itemBuilder: (context, index) {
              final word = words[index];
              return FlipCard(
                key: ValueKey(word),
                front: Card(
                  child: Center(child: Text(getEword(word))),
                ),
                back: Card(
                  child: Center(child: Text(getMeaning(word))),
                ),
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
