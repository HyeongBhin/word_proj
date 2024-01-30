import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'Login_Page.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  String _errorMessage = '';

  void _Signup() async {
    if (_passwordController.text == _confirmPasswordController.text) {
      try {
        await _auth.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()), // LoginPage로 이동
        );
      } on FirebaseAuthException catch (e) {
        String errorMessage;
        switch (e.code) {
          case 'invalid-email':
            errorMessage = '이메일의 형식이 올바르지 않습니다';
            break;
          case 'email-already-in-use':
            errorMessage = '이미 등록된 이메일입니다';
            break;
          default:
            errorMessage =
                e.message ?? 'An error occurred during registration.';
            break;
        }
        setState(() {
          _errorMessage = errorMessage;
        });
      }
    } else {
      setState(() {
        _errorMessage = 'Passwords do not match.';
      });
    }
  }

  bool _isSignupButtonEnabled() {
    return _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _confirmPasswordController.text.isNotEmpty &&
        _passwordController.text == _confirmPasswordController.text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('회원가입'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_errorMessage.isNotEmpty)
              Text(
                _errorMessage,
                style: TextStyle(color: Colors.red, fontSize: 14),
              ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
              onChanged: (_) => setState(() {}),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
              onChanged: (_) => setState(() {}),
            ),
            TextField(
              controller: _confirmPasswordController,
              decoration: InputDecoration(labelText: 'Confirm Password'),
              obscureText: true,
              onChanged: (_) => setState(() {}),
            ),
            ElevatedButton(
              onPressed: _isSignupButtonEnabled() ? _Signup : null,
              child: Text('회원가입'),
            ),
          ],
        ),
      ),
    );
  }
}
