import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'SheetSelection_Page.dart';
import 'Selection_Page.dart';
import 'ChapterSelection_Card.dart';
import 'ChapterSelection_Quiz.dart';
import 'Login_Page.dart';
import 'firebase_options.dart';
import 'review_page.dart';
import 'main_Page.dart';
import 'word_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SheetIdProvider()),
      ],
      child: MaterialApp(
        // home: LoginPage(), // 이전 코드에서는 LoginPage를 직접 지정했습니다.
        home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              // 스트림이 활성 상태이고, 데이터(snapshot)가 있으면 사용자가 로그인한 것입니다.
              User? user = snapshot.data;
              if (user == null) {
                // 사용자 데이터가 없으면 로그인 페이지로 이동합니다.
                return LoginPage();
              } else {
                // 사용자 데이터가 있으면 메인 페이지로 이동합니다.
                return MainPage();
              }
            }
            // 스트림이 아직 활성 상태가 아니면 로딩 인디케이터를 보여줍니다.
            return Center(child: CircularProgressIndicator());
          },
        ),
        routes: {
          '/word_login': (context) => LoginPage(),
          '/word_main': (context) => MainPage(),
          '/sheet_select': (context) => SheetSelectionPage(),
          '/select_list': (context) => SelectPage(),
          '/word_card': (context) => ChapterSelection_Card(),
          '/word_quiz': (context) => ChapterSelection_Quiz(),
          '/review_page': (context) => ReviewPage(),
          // 추가로 필요한 경로와 위젯을 여기에 매핑할 수 있습니다.
        },
      ),
    );
  }
}
