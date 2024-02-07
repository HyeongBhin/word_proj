import 'package:flutter/material.dart';
import 'dart:math';

class FlipCardView<T> extends StatefulWidget {
  final T word;
  final String frontText;
  final String backText;

  FlipCardView({required this.word, required this.frontText, required this.backText});

  @override
  _FlipCardViewState createState() => _FlipCardViewState();
}

class _FlipCardViewState extends State<FlipCardView> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool isFront = true; // 카드가 앞면인지 여부를 추적하는 변수

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed || status == AnimationStatus.dismissed) {
          // 애니메이션의 시작과 끝에서 카드의 면 상태를 업데이트합니다.
          setState(() {
            isFront = !isFront;
          });
        }
      });
  }

  void _flipCard() {
    if (_controller.isAnimating) {
      return;
    }
    if (_controller.isCompleted) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    // 애니메이션 값에 따라 회전 각도를 계산합니다.
    final angle = _controller.value * pi;
    final transform = Matrix4.identity()
      ..setEntry(3, 2, 0.001) // 3D 효과를 위한 perspective
      ..rotateY(angle);

    // 애니메이션 각도에 따라 카드의 앞면 또는 뒷면을 결정합니다.
    bool showFront = _controller.value < 0.5;

    return GestureDetector(
      onTap: _flipCard,
      child: Transform(
        transform: transform,
        alignment: Alignment.center,
        child: showFront
            ? Card(
          child: Center(
            child: Text(widget.frontText, style: TextStyle(fontSize: 19)),
          ),
        )
            : Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()..rotateY(pi),
          child: Card(
            color: Colors.blue[100], // 뒷면의 색상을 약간 변경하여 구분을 쉽게 할 수 있습니다.
            child: Center(
              child: Text(widget.backText, style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
