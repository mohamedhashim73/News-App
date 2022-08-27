import 'package:flutter/material.dart';
Widget DefaultTextFormField ({
  required TextEditingController controller,
  required TextInputType type,
  Text? label,
  required Function validatorFunction,
}) {
  return TextFormField(
    keyboardType: type,
    controller: controller,
    validator: validatorFunction(),
    decoration: InputDecoration(
      label: label,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
    ),
  );
}