import 'package:flutter/material.dart';

class FilterBar extends StatefulWidget {
  @override
  _FilterBarState createState() => _FilterBarState();
}

class _FilterBarState extends State<FilterBar> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ExpansionPanelList(
        elevation: 0, 
        expandedHeaderPadding: EdgeInsets.zero, 
        expansionCallback: (int index, bool isExpanded) {
          setState(() {
            _isExpanded = !_isExpanded; 
          });
        },
        children: [
          ExpansionPanel(
            headerBuilder: (BuildContext context, bool isExpanded) {
              return ListTile(
                title: Text(
                  'Filter',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              );
            },
            backgroundColor: Colors.white,
            body: Container( 
              padding: EdgeInsets.symmetric(vertical: 10), 
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FilterButton(label: 'Vencidos'),
                  FilterButton(label: 'Próximos'),
                  FilterButton(label: 'Não Vencidos'),
                ],
              ),
            ),
            isExpanded: _isExpanded,
            canTapOnHeader: true, 
          ),
        ],
      ),
    );
  }
}

class FilterButton extends StatelessWidget {
  final String label;

  const FilterButton({required this.label});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
        backgroundColor: Color(0xFF4A628A),
        foregroundColor: Colors.white,
        elevation: 4,
      ),
      child: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 13,
        ),
      ),
    );
  }
}
