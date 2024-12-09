import 'package:flutter/material.dart';
class ExpenseDetails extends StatelessWidget {
  const ExpenseDetails({
    super.key,
    required this.textController,
    required this.hintText,
    required this.prefixIcon,
    required this.onTap,
    required this.readOnly,
  });

  final TextEditingController textController;
  final String hintText;
  final Icon prefixIcon;
  final VoidCallback? onTap;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 30),
      child: TextFormField(
        readOnly: readOnly,
        onTap: onTap,
        controller: textController,
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: hintText,
            prefixIcon: prefixIcon,
            border:
            OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      ),
    );
  }
}