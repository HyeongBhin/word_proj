import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ReviewPage extends StatefulWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final int _perPage = 10; // 한 페이지당 문서 개수
  DocumentSnapshot? _lastDocument; // 마지막 문서를 추적
  bool _hasMoreData = true; // 더 많은 데이터가 있는지 여부
  List<DocumentSnapshot> _quizResults = []; // 퀴즈 결과 리스트

  @override
  void initState() {
    super.initState();
    _loadQuizResults();
  }

  // Firestore에서 사용자의 퀴즈 결과를 가져오는 함수
  Future<void> _loadQuizResults() async {
    User? user = _auth.currentUser;
    if (user != null) {
      Query query = FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('quizResults')
          .orderBy('date', descending: true)
          .limit(_perPage);

      if (_lastDocument != null) {
        query = query.startAfterDocument(_lastDocument!);
      }

      QuerySnapshot querySnapshot = await query.get();

      if (querySnapshot.docs.length < _perPage) {
        _hasMoreData = false;
      }

      if (querySnapshot.docs.isNotEmpty) {
        _lastDocument = querySnapshot.docs.last;
      }

      setState(() {
        _quizResults.addAll(querySnapshot.docs);
      });
    } else {
      throw Exception('User not logged in');
    }
  }

  // 사용자가 더 많은 데이터를 요청할 때 호출되는 함수
  Future<void> _loadMoreQuizResults() async {
    if (_hasMoreData) {
      await _loadQuizResults();
    }
  }
  // Firestore에서 사용자의 퀴즈 결과를 가져오는 함수
  Stream<QuerySnapshot> _getQuizResults() {
    User? user = _auth.currentUser;
    if (user != null) {
      return FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('quizResults')
          .orderBy('date', descending: true) // 최신 결과가 위로 오도록 정렬
          .snapshots();
    } else {
      throw Exception('User not logged in');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Review Quiz Results'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _getQuizResults(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No quiz results found'));
          }

          // 결과 문서들을 리스트로 변환합니다.
          List<DocumentSnapshot> quizResults = snapshot.data!.docs;

          return ListView.builder(
            itemCount: quizResults.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> data = quizResults[index].data() as Map<String, dynamic>;
              DateTime date = (data['date'] as Timestamp).toDate();
              String chapter = data['chapter'] ?? 'Unknown Chapter';
              List<dynamic> incorrectWords = data['incorrectWords'];

              return Card(
                child: ListTile(
                  title: Text('Quiz on ${date.toString()} - $chapter'),
                  subtitle: Text('Incorrect Answers: ${incorrectWords.length}'),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Incorrect Answers'),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: incorrectWords.map((incorrectWord) {
                                return Padding(
                                  padding:
                                  const EdgeInsets.symmetric(vertical: 4.0),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text('Word: ${incorrectWord['word']}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      Text(
                                          'Correct Answer: ${incorrectWord['correctAnswer']}'),
                                      Text(
                                          'Your Answer: ${incorrectWord['submittedAnswer']}'),
                                      SizedBox(height: 10),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: Text('Close'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
