  import 'package:flutter/material.dart';
  import '../utils/date_utils.dart';

  class DateSelector extends StatelessWidget {
    final DateTime selectedDate;
    final Function(BuildContext) onSelectDate; 

    DateSelector({required this.selectedDate, required this.onSelectDate});

    @override
    Widget build(BuildContext context) {
      return GestureDetector(
        onTap: () => onSelectDate(context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildDateBox("${selectedDate.day}"),
            Text('/', style: TextStyle(fontSize: 24, color: Colors.black54)),
            _buildDateBox(monthName(selectedDate.month)),
            Text('/', style: TextStyle(fontSize: 24, color: Colors.black54)),
            _buildDateBox("${selectedDate.year}"),
          ],
        ),
      );
    }

    Widget _buildDateBox(String text) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.white,
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Text(text, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
      );
    }
  }
