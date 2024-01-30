// word_data.dart
import 'package:googleapis/sheets/v4.dart' as sheets;
import 'package:googleapis_auth/auth_io.dart';
import 'Word.dart';

class WordData {
  static const _scopes = [sheets.SheetsApi.spreadsheetsScope];

  static Future<Map<String, List<Word>>> loadDataFromSheets(String sheet) async {
    var _credentials = ServiceAccountCredentials.fromJson({
      "type": "service_account",
      "project_id": "sheetgpt-408209",
      "private_key_id": "f902763975826619068c6efd246924ff12e22cb4",
      "private_key":
      "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDaVMQJLKhmCthO\ndwhi/jmh9bDdZrrVYkWJcZqtFMIuH0ZZAwJZ3WtBUYTt+SZJFtJJrWp80/dkTRE7\nieTn766QVMGX0n5Y+2giiyhWK/cUq/89I1Dd9bLsNDai5FbK52CmKeQIXCdSFl6U\n7uVj7REbyjBgIzJ8V/lkxn4DUPVVr0/GqA79vDH/eqXBFNfFhbB96XufTCwyDhtV\n77rONnskFiQZgFUpyB3/jfQ7kKUQU0aYtuaffrlHeEg4sz2Hl7qCSGTrMr0rb2wo\nWloDaAGn2mYSQ35RtfzBdkdnrZrGua6bh7UHVC2E6fuSaD3YoYKs8EZGoY+CKQ08\nT32v8Z0vAgMBAAECggEAVsMDqi+sdeyOW9QSqaAkT/e+QqVtzplAT+es02Yh6kk0\nX/ABsat7UVgvTpBJhhcDFxNKc3OaZqn3lKTuKbtGMAX2brpPylWR4tRRAblz9SuK\ngQW1P5dBdHslUSMTWIuNDUstWqMgXw8To/SxhL2zJEt7YODr0Zz2NvVoIzI7ZEJM\nLqooAIP3cc+9FIGxcqEjIfl7Hval7FLctK3iIqhc1L9TY6ODDRxfXDKMvrXIC8Ac\nehPPSurqqzawDEGQjztTX21Ym/0VCH2ksOqAi9QvV3F1ImluLgiYEmmRp2ikl4xa\n1pYY65HR/NHYjktt/vITaAfdNr6DEqIHBe0QpkWPfQKBgQDxAdM6KFiSKBKf61AK\n8B4VYh0wNU/aUQCDbIqPYW+LOg8/v+h4FvuAecEpvJszUv3m73k5oqwoiTvBdXts\n2fXM1+5zsLDk4ibEOZwbQ2J2QTe80lzS1WxumguRCetue8Wi39dc5bmcgfgTFaaz\nkkcMQajJYWno0f3aq3eqkCYJZQKBgQDn6c/0Ru/1ZsGOyPfAvCgBTpUEKzhlLNPX\n9O3yaYYDFf+i5jLF4kpY72gEdEnR6wU61k/uR3jg2BhKooIxhcTvlGoIff8AXHwC\nbyMLUp1fXhNgrFoBfuyFXv4c9EcjtGRmh99GsRSrp08jpWMjPvc0IaHmLOc568ev\nWDVVf0ntAwKBgQCnDO7OVvzdge0277IxgrI3fCRjL/DDkHXcorWAILdiN8IuG+UU\nqEl3ie078sFY1+Op2L+cFYdjKYxD0hzVHFblv55GjmhundrlFFGCDDkJYrcxqFYy\nxUA9gYUW6VtI333kIWdzur/nHadIAy/jNDcO5cwKmf0BJdzhXwy5KuVSiQKBgQDg\nINZqJTh4+VLs1IqkCPO8t55Khh6doSInHr3rvlHWn6cMXt8I4Xaq1sy3KU/CgRjv\n0Pk0tnw7CH0JfF7Iz5gRVmTXSjVsuvTaQWAj7DbNWRTvJAJkWa7qAnEhuG8cMZWq\nhXuiTTdF4Y8ZSxgxkwPDrRFTa2gYUScN7fi1ZSwj0wKBgHj7cvZalsOk0a9VLHYY\nsEkSQyOVTmY1lRCEQZWr9LJKFxDx8QrgcyhSVuqfCEzO9zlAju/JQFFsGRuKU3yj\nflWV1syjon0LkyO1GT4gS++m6DgbqT6XKc4LC/q5V7teo6z001dFTjAiYGg5alQo\nQ5x6s4Sjk0dLwKS01N912NWG\n-----END PRIVATE KEY-----\n",
      "client_email": "sheet-65@sheetgpt-408209.iam.gserviceaccount.com",
      "client_id": "102008550720276328590",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url":
      "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url":
      "https://www.googleapis.com/robot/v1/metadata/x509/sheet-65%40sheetgpt-408209.iam.gserviceaccount.com",
      "universe_domain": "googleapis.com"
    });

    // HTTP 클라이언트 생성
    final httpClient = await clientViaServiceAccount(_credentials, _scopes);
    var api = sheets.SheetsApi(httpClient);

    try {
      final spreadsheetId = '1bUxqmSra1z0KCeZObaVK0Y7rtTVx_hYxeZj2ecrVxgA';

      // 시트1의 데이터 가져오기
      final rangeSheet1 = '시트1!A:B';
      var responseSheet1 =
      await api.spreadsheets.values.get(spreadsheetId, rangeSheet1);

      // 시트2의 데이터 가져오기
      final rangeSheet2 = '시트2!A:B';
      var responseSheet2 =
      await api.spreadsheets.values.get(spreadsheetId, rangeSheet2);

      // 시트3의 데이터 가져오기
      final rangeSheet3 = '시트3!A:B';
      var responseSheet3 =
      await api.spreadsheets.values.get(spreadsheetId, rangeSheet3);

      // 시트4의 데이터 가져오기
      final rangeSheet4 = '시트4!A:B';
      var responseSheet4 =
      await api.spreadsheets.values.get(spreadsheetId, rangeSheet4);

      // 시트5의 데이터 가져오기
      final rangeSheet5 = '시트5!A:B';
      var responseSheet5 =
      await api.spreadsheets.values.get(spreadsheetId, rangeSheet5);

      List<Word> wordsSheet1 = [];
      List<Word> wordsSheet2 = [];
      List<Word> wordsSheet3 = [];
      List<Word> wordsSheet4 = [];
      List<Word> wordsSheet5 = [];

      // 시트1 데이터를 Word_1 객체로 변환
      if (responseSheet1.values != null && responseSheet1.values!.isNotEmpty) {
        wordsSheet1 = responseSheet1.values!
            .where((wordData) => wordData.length >= 2)
            .map((wordData) {
          final eword_1 = wordData[0];
          final meaning_1 = wordData[1];
          if (eword_1 is String && meaning_1 is String) {
            return Word_1(eword_1: eword_1, meaning_1: meaning_1);
          }
          return null;
        })
            .whereType<Word_1>() // null이 아닌 Word_1 객체만 유지
            .toList();
      }

      // 시트2 데이터를 Word_2 객체로 변환
      if (responseSheet2.values != null && responseSheet2.values!.isNotEmpty) {
        wordsSheet2 = responseSheet2.values!
            .where((wordData) => wordData.length >= 2)
            .map((wordData) {
          final eword_2 = wordData[0];
          final meaning_2 = wordData[1];
          if (eword_2 is String && meaning_2 is String) {
            return Word_2(eword_2: eword_2, meaning_2: meaning_2);
          }
          return null;
        })
            .whereType<Word_2>() // null이 아닌 Word_2 객체만 유지
            .toList();
      }

      // 시트3 데이터를 Word_3 객체로 변환
      if (responseSheet3.values != null && responseSheet3.values!.isNotEmpty) {
        wordsSheet3 = responseSheet3.values!
            .where((wordData) => wordData.length >= 2)
            .map((wordData) {
          final eword_3 = wordData[0];
          final meaning_3 = wordData[1];
          if (eword_3 is String && meaning_3 is String) {
            return Word_3(eword_3: eword_3, meaning_3: meaning_3);
          }
          return null;
        })
            .whereType<Word_3>() // null이 아닌 Word_3 객체만 유지
            .toList();
      }

      // 시트2 데이터를 Word_4 객체로 변환
      if (responseSheet4.values != null && responseSheet4.values!.isNotEmpty) {
        wordsSheet4 = responseSheet4.values!
            .where((wordData) => wordData.length >= 2)
            .map((wordData) {
          final eword_4 = wordData[0];
          final meaning_4 = wordData[1];
          if (eword_4 is String && meaning_4 is String) {
            return Word_4(eword_4: eword_4, meaning_4: meaning_4);
          }
          return null;
        })
            .whereType<Word_4>() // null이 아닌 Word_4 객체만 유지
            .toList();
      }

      // 시트5 데이터를 Word_5 객체로 변환
      if (responseSheet5.values != null && responseSheet5.values!.isNotEmpty) {
        wordsSheet5 = responseSheet5.values!
            .where((wordData) => wordData.length >= 2)
            .map((wordData) {
          final eword_5 = wordData[0];
          final meaning_5 = wordData[1];
          if (eword_5 is String && meaning_5 is String) {
            return Word_5(eword_5: eword_5, meaning_5: meaning_5);
          }
          return null;
        })
            .whereType<Word_5>() // null이 아닌 Word_5 객체만 유지
            .toList();
      }


      List<Word> allWords = [];
      allWords.addAll(wordsSheet1);
      allWords.addAll(wordsSheet2);
      allWords.addAll(wordsSheet3);
      allWords.addAll(wordsSheet4);
      allWords.addAll(wordsSheet5);


      // 시트1과 시트2의 데이터를 각각 반환
      return {
        'Chapter1': wordsSheet1.cast<Word>(),
        'Chapter2': wordsSheet2.cast<Word>(),
        'Chapter3': wordsSheet3.cast<Word>(),
        'Chapter4': wordsSheet4.cast<Word>(),
        'Chapter5': wordsSheet5.cast<Word>(),
        'AllWords': allWords.cast<Word>(),
      };

    } catch (e) {
      // 예외 처리
      print('Sheets에서 데이터를 불러오는 중 오류 발생: $e');
      return {};
    } finally {
      // HTTP 클라이언트 종료
      httpClient.close();
    }
  }
}