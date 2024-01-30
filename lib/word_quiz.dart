import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'word_data.dart';
import 'Word.dart';

class QuizPage extends StatefulWidget {
  final String Chapter;

  QuizPage({required this.Chapter});

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Word>? wordsList = [];
  Future<List<Word>>? _wordsFuture;
  List<Word>? _quizWords;
  Map<String, List<String>>? _options;
  Map<String, String> _selectedOptions = {};
  Map<String, String> _correctAnswers = {};

  bool _isCheckButtonEnabled = true;

  @override
  void initState() {
    super.initState();
    _wordsFuture = _loadWords(); // 비동기 작업을 별도의 함수로 분리
    _generateQuiz();
  }

  Future<List<Word>> _loadWords() async {
    try {
      Map<String, List<Word>> data = await WordData.loadDataFromSheets(widget.Chapter);
      List<Word> wordsList = data[widget.Chapter] ?? []; // 해당 시트에 대한 데이터 추출
      debugPrint('Words loaded successfully');
      return wordsList;
    } catch (e) {
      debugPrint('Failed to load words: $e');
      rethrow;
    }
  }

  void _generateQuiz() async {
    final List<Word>? wordsList = await _wordsFuture;
    if (wordsList != null) {
      wordsList.shuffle();
      _quizWords = wordsList.take(20).toList(); // 문제 갯수 선택하기
      _options = {};
      for (var word in _quizWords!) {
        _correctAnswers[word.eword] = word.meaning;
        List<String> allMeanings = wordsList.map((e) => e.meaning).toList();
        allMeanings.shuffle();
        allMeanings.removeWhere((meaning) => meaning == word.meaning);
        _options![word.eword] = allMeanings.take(4).toList()..add(word.meaning); //보기 갯수 선택하기
        _options![word.eword]!.shuffle();
      }
      if (mounted) {
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz'),
      ),
      body: FutureBuilder<List<Word>>(
        future: _wordsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // 에러가 있는 경우 에러 메시지를 화면에 표시합니다.
            debugPrint('FutureBuilder Error: ${snapshot.error}');
            return Center(child: Text('Error: ${snapshot.error}')); // 에러 메시지를 UI에 표시
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No words available'));
          }

          // 변경: _quizWords가 null이거나 비어있는지 확인
          if (_quizWords == null || _quizWords!.isEmpty) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: _quizWords!.length,
            itemBuilder: (context, index) {
              final word = _quizWords![index];
              return Card(
                child: Column(
                  children: [
                    Text(word.eword, style: TextStyle(fontSize: 24)),
                    ...?_options?[word.eword]?.map((option) {
                      // 변경: 옵셔널 체이닝 사용
                      return ListTile(
                        title: Text(option),
                        leading: Radio<String>(
                          value: option,
                          groupValue: _selectedOptions[word.eword],
                          onChanged: (String? value) {
                            if (value != null) {
                              setState(() {
                                _selectedOptions[word.eword] = value;
                              });
                            }
                          },
                        ),
                      );
                    }).toList(), // map 결과를 리스트로 변환
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _checkAnswers,
        child: Icon(Icons.check),
      ),
    );
  }

  void _checkAnswers() {
    List<Word> incorrectWords = [];

    for (Word word in _quizWords!) {
      if (_selectedOptions[word.eword] != word.meaning) {
        incorrectWords.add(word);
      }
    }
    // 결과를 Firestore에 저장합니다.
    _saveQuizResults(incorrectWords);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Quiz Results'),
          content: SingleChildScrollView(
            // 스크롤 가능한 뷰를 추가합니다.
            child: ListBody(
              // ListBody를 사용하여 리스트 아이템들을 순서대로 정렬합니다.
              children: _quizWords!.map((word) {
                final userAnswer = _selectedOptions[word.eword];
                final isCorrect = userAnswer == word.meaning;
                return ListTile(
                  title: Text(word.eword),
                  subtitle: Text(userAnswer ?? 'No answer'),
                  trailing: Icon(
                    isCorrect ? Icons.check_circle : Icons.cancel,
                    color: isCorrect ? Colors.green : Colors.red,
                  ),
                );
              }).toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
  // FirebaseAuth 인스턴스를 가져옵니다.
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Firestore에 퀴즈 결과를 저장하는 함수
  Future<void> _saveQuizResults(List<Word> incorrectWords) async {
    User? user = _auth.currentUser;
    if (user != null) {
      final CollectionReference userResults = FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('quizResults');

      final now = DateTime.now();

      var chapter = widget.Chapter;

      await userResults.add({
        'date': now,
        'chapter': chapter, // Add the 'chapter' field here.
        'incorrectWords': incorrectWords
            .map((word) => {
          'word': word.eword,
          'submittedAnswer': _selectedOptions[word.eword],
          'correctAnswer': word.meaning,
        })
            .toList(),
      });
    } else {
      // Handle the case when the user is not logged in.
      print('User is not logged in.');
    }
  }
}
