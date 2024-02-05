import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Selection_Page.dart';
import 'word_data.dart';
import 'Sheet_data.dart';

class SheetSelectionPage extends StatefulWidget {
  @override
  _SheetSelectionPageState createState() => _SheetSelectionPageState();
}

class _SheetSelectionPageState extends State<SheetSelectionPage> {
  final Exam exam = Exam();
  String? selectedSheetId; // 사용자가 선택한 sheetId를 저장할 변수

  @override
  void initState() {
    super.initState();
    exam.loadSheetData().then((_) {
      setState(() {});
    }).catchError((error) {
      print("Error loading data: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exam List'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: exam.examList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: ElevatedButton(
                    onPressed: () {
                      final provider = Provider.of<SheetIdProvider>(context, listen: false);
                      provider.sheetId = exam.examListID[index];

                      print("Selected sheetId: ${provider.sheetId}");
                    },
                    child: Text(exam.examList[index]),
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/select_list');
            },
            child: Text('다음'),
          ),
        ],
      ),
    );
  }
}
