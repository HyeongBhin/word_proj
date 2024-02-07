import 'package:flutter/material.dart';

class SelectPage extends StatelessWidget {


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
              child: Text('영어 단어장'),
              onPressed: () {
                Navigator.pushNamed(context, '/word_card');
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('단어 시험'),
              onPressed: () {
                Navigator.pushNamed(context, '/word_quiz');
              },
            ),
          ],
        ),
      ),
    );
  }
}