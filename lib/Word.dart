abstract class Word {
  String get eword;

  String get meaning;

  static fromMap(wordMap) {}
}

class Word_1 extends Word {
  final String eword_1;
  final String meaning_1;

  Word_1({required this.eword_1, required this.meaning_1});

  @override
  String get eword => eword_1;

  @override
  String get meaning => meaning_1;

  // Word_1.fromMap 팩토리 생성자
  factory Word_1.fromMap(Map<String, dynamic> map) {
    return Word_1(
      eword_1: map['eword_1'] as String, // 'eword_1' 키를 사용하여 값을 추출합니다.
      meaning_1: map['meaning_1'] as String, // 'meaning_1' 키를 사용하여 값을 추출합니다.
    );
  }
}

class Word_2 extends Word {
  final String eword_2;
  final String meaning_2;

  Word_2({required this.eword_2, required this.meaning_2});

  @override
  String get eword => eword_2;

  @override
  String get meaning => meaning_2;

  // Word_2.fromMap 팩토리 생성자
  factory Word_2.fromMap(Map<String, dynamic> map) {
    return Word_2(
      eword_2: map['eword_2'] as String, // 'eword_2' 키를 사용하여 값을 추출합니다.
      meaning_2: map['meaning_2'] as String, // 'meaning_2' 키를 사용하여 값을 추출합니다.
    );
  }
}

class Word_3 extends Word {
  final String eword_3;
  final String meaning_3;

  Word_3({required this.eword_3, required this.meaning_3});

  @override
  String get eword => eword_3;

  @override
  String get meaning => meaning_3;

  // Word_2.fromMap 팩토리 생성자
  factory Word_3.fromMap(Map<String, dynamic> map) {
    return Word_3(
      eword_3: map['eword_3'] as String, // 'eword_3' 키를 사용하여 값을 추출합니다.
      meaning_3: map['meaning_3'] as String, // 'meaning_3' 키를 사용하여 값을 추출합니다.
    );
  }
}

class Word_4 extends Word {
  final String eword_4;
  final String meaning_4;

  Word_4({required this.eword_4, required this.meaning_4});

  @override
  String get eword => eword_4;

  @override
  String get meaning => meaning_4;

  // Word_2.fromMap 팩토리 생성자
  factory Word_4.fromMap(Map<String, dynamic> map) {
    return Word_4(
      eword_4: map['eword_4'] as String, // 'eword_4' 키를 사용하여 값을 추출합니다.
      meaning_4: map['meaning_4'] as String, // 'meaning_4' 키를 사용하여 값을 추출합니다.
    );
  }
}

class Word_5 extends Word {
  final String eword_5;
  final String meaning_5;

  Word_5({required this.eword_5, required this.meaning_5});

  @override
  String get eword => eword_5;

  @override
  String get meaning => meaning_5;

  // Word_2.fromMap 팩토리 생성자
  factory Word_5.fromMap(Map<String, dynamic> map) {
    return Word_5(
      eword_5: map['eword_5'] as String, // 'eword_5' 키를 사용하여 값을 추출합니다.
      meaning_5: map['meaning_5'] as String, // 'meaning_5' 키를 사용하여 값을 추출합니다.
    );
  }
}
