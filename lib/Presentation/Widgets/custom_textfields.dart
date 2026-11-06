import 'package:flutter/material.dart';

class CustomTextfields extends StatelessWidget {
  final String hint_text;
  final TextEditingController controller;
  const CustomTextfields({super.key, required this.hint_text, required this.controller});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'This Field is Required';
          } else if (value.length < 3) {
            return 'Lenght Should Be More Than 3 ';
          }
          return null;
        },
        controller: controller,
        decoration: InputDecoration(
          hintText: hint_text,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        ),
      ),
    );
  }
}
