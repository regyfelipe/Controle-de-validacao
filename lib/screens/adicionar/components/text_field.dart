import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final IconData icon;
  final TextEditingController controller; 

  CustomTextField({
    required this.label,
    required this.icon,
    required this.controller, 
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller, 
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.deepPurpleAccent),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

class CustomSimpleTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller; 

  CustomSimpleTextField({
    required this.label,
    required this.controller, 
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

class CustomTextFieldArea extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller; 

  CustomTextFieldArea({
    required this.label,
    required this.hint,
    required this.controller, 
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 14, color: Colors.black87)),
        SizedBox(height: 8),
        TextField(
          controller: controller, 
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
