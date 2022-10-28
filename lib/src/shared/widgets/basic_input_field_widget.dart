import 'package:flutter/material.dart';

class BasicInputFieldWidget extends StatelessWidget {
  final void Function(String)? onChanged;
  final String label;
  final bool isPassword;
  final TextInputType textInputType;
  final String? initialValue;
  const BasicInputFieldWidget({
    super.key,
    required this.onChanged,
    required this.label,
    this.isPassword = false,
    this.textInputType = TextInputType.text,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      onChanged: onChanged,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      obscureText: isPassword,
      keyboardType: textInputType,
    );
  }
}
