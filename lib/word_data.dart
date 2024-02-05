import 'package:googleapis/sheets/v4.dart' as sheets;
import 'package:googleapis_auth/auth_io.dart';
import 'package:flutter/foundation.dart';

import 'SheetSelection_Page.dart';
import 'Word.dart';

class SheetIdProvider with ChangeNotifier {
  String? _sheetId;

  String? get sheetId => _sheetId;

  set sheetId(String? newSheetId) {
    _sheetId = newSheetId;
    notifyListeners(); // sheetId 값이 변경될 때 리스너에게 알림
  }
}

class WordData {
  static const _scopes = [sheets.SheetsApi.spreadsheetsScope];

  static Future<Map<String, List<Word>>> loadDataFromSheets(SheetIdProvider provider, String sheetname) async {
    String? sheetId = provider.sheetId;

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
      // 시트의 데이터를 가져와서 Word 객체 리스트로 변환하는 함수
      Future<List<Word>> loadSheetData(String sheetName, Function converter) async {

        final range = '$sheetName!A:B';
        var response = await api.spreadsheets.values.get(sheetId!, range);
        if (response.values != null && response.values!.isNotEmpty) {
          return response.values!
              .where((wordData) => wordData.length >= 2)
              .map((wordData) => converter(wordData))
              .whereType<Word>()
              .toList();
        }
        return [];
      }

      // 각 시트의 데이터를 불러오고 Word 객체로 변환
      var wordsSheet1 = await loadSheetData('시트1', (data) => Word_1(eword_1: data[0], meaning_1: data[1]));
      var wordsSheet2 = await loadSheetData('시트2', (data) => Word_2(eword_2: data[0], meaning_2: data[1]));
      var wordsSheet3 = await loadSheetData('시트3', (data) => Word_3(eword_3: data[0], meaning_3: data[1]));
      var wordsSheet4 = await loadSheetData('시트4', (data) => Word_4(eword_4: data[0], meaning_4: data[1]));
      var wordsSheet5 = await loadSheetData('시트5', (data) => Word_5(eword_5: data[0], meaning_5: data[1]));

      List<Word> allWords = [];
      allWords.addAll(wordsSheet1);
      allWords.addAll(wordsSheet2);
      allWords.addAll(wordsSheet3);
      allWords.addAll(wordsSheet4);
      allWords.addAll(wordsSheet5);

      // 시트1부터 시트5까지의 데이터와 모든 단어를 반환
      return {
        'Chapter1': wordsSheet1,
        'Chapter2': wordsSheet2,
        'Chapter3': wordsSheet3,
        'Chapter4': wordsSheet4,
        'Chapter5': wordsSheet5,
        'AllWords': allWords,
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
