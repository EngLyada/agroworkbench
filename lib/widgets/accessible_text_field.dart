import 'package:flutter/material.dart';

import '../utils/accessibility_helper.dart';

class AccessibleTextField extends StatelessWidget {
  final String label;
  final String hint;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final TextInputType keyboardType;
  final bool obscureText;
  final String? initialValue;
  final TextEditingController? controller;

  const AccessibleTextField({
    Key? key,
    required this.label,
    required this.hint,
    this.validator,
    this.onChanged,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.initialValue,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Ensure we don't set both initialValue and controller
    assert(initialValue == null || controller == null, 
      'Cannot provide both initialValue and controller to AccessibleTextField');

    return Semantics(
      textField: true,
      label: label,
      child: TextFormField(
        // Only set controller if initialValue is null
        controller: initialValue == null ? controller : null,
        // Only set initialValue if controller is null
        initialValue: controller == null ? initialValue : null,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: const OutlineInputBorder(),
        ),
        validator: validator,
        onChanged: onChanged,
        keyboardType: keyboardType,
        obscureText: obscureText,
        style: AccessibilityHelper.getAccessibleTextStyle(
          fontSize: 16,
        ),
      ),
    );
  }
}