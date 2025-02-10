import 'package:flutter/material.dart';

class Tff extends StatelessWidget {
  final Function(String s)? onSaved;
  final Function(String s)? onValidate;
  final Function(String s)? onChanged;
  final TextInputType? type;
  final String? label, initialValue;
  final bool? obscureText;
  const Tff({
    super.key,
    this.type = TextInputType.text,
    this.initialValue,
    this.onValidate,
    this.onChanged,
    this.onSaved,
    this.label,
    this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText ?? false,
      initialValue: initialValue,
      onSaved: (v) => onSaved!(v!),
      validator: (v) => onValidate!(v!),
      onChanged: (v) => onChanged!(v),
      keyboardType: type,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(top: 4.0, bottom: 4.0, left: 12.0),
        label: Text(label ?? ''),
        labelStyle: const TextStyle(color: Colors.white, fontSize: 17.0),
      ),
    );
  }
}
