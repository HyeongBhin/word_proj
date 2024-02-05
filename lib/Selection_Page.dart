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
          ],
        ),
      ),
    );
  }
}