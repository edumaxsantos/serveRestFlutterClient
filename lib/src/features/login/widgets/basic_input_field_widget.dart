import 'package:flutter/material.dart';

class BasicInputFieldWidget extends StatelessWidget {
  final void Function(String)? onChanged;
  final String label;
  final bool isPassword;
  const BasicInputFieldWidget({
    super.key,
    required this.onChanged,
    required this.label,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      obscureText: isPassword,
    );
  }
}
