// filter_widget.dart
import 'package:flutter/material.dart';

typedef FilterCallback = void Function(String? chapter, DateTime? date);

class FilterWidget extends StatefulWidget {
  final FilterCallback onFilterChanged;

  FilterWidget({required this.onFilterChanged});

  @override
  _FilterWidgetState createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  String? _selectedChapter;
  DateTime? _selectedDate;

  // 드롭다운 메뉴에서 사용할 챕터 목록
  final List<String> _chapters = ['Chapter 1', 'Chapter 2', 'Chapter 3', 'Chapter 4'];

  // 필터 UI 구성
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 챕터 선택 드롭다운
        DropdownButton<String>(
          value: _selectedChapter,
          hint: Text('Select Chapter'),
          items: _chapters.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (newValue) {
            updateFilters(newValue, _selectedDate);
          },
        ),
        // 날짜 선택 버튼
        TextButton(
          onPressed: () async {
            final DateTime? picked = await showDatePicker(
              context: context,
              initialDate: _selectedDate ?? DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2101),
            );
            if (picked != null && picked != _selectedDate) {
              updateFilters(_selectedChapter, picked);
            }
          },
          child: Text(
            _selectedDate != null ? 'Selected Date: ${_selectedDate!.toLocal()}'.split(' ')[0] : 'Select Date',
          ),
        ),
      ],
    );
  }

  // 필터링 로직 (예: 쿼리 업데이트)
  void updateFilters(String? chapter, DateTime? date) {
    setState(() {
      _selectedChapter = chapter;
      _selectedDate = date;
      widget.onFilterChanged(_selectedChapter, _selectedDate); // 상태 변경 알림
    });
  }
}
