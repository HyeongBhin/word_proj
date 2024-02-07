import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // FirebaseAuth를 사용하기 위해 추가

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 현재 로그인한 사용자의 이메일 주소를 가져옵니다.
    final String userEmail = FirebaseAuth.instance.currentUser?.email ?? '로그인 정보 없음';

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // 사용자 이메일 주소를 AppBar에 표시합니다.
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Text(
                  userEmail,
                  style: TextStyle(
                    color: Colors.black, // AppBar의 배경색에 따라 색상을 조정하세요.
                    fontSize: 16,
                  ),
                ),
              ),
              // 로그아웃 버튼을 AppBar에 배치합니다.
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: TextButton.icon(
                  icon: Icon(Icons.logout, color: Colors.black),
                  label: Text('로그아웃', style: TextStyle(color: Colors.black)),
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushReplacementNamed(context, '/word_login');
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // 여기서는 사용자 이메일 주소를 표시하지 않습니다.
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('시험 선택하기'),
              onPressed: () {
                Navigator.pushNamed(context, '/sheet_select');
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('퀴즈 결과 모음'),
              onPressed: () {
                Navigator.pushNamed(context, '/review_page');
              },
            ),
          ],
        ),
      ),
    );
  }
}
