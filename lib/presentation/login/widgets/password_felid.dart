import 'package:flutter/material.dart';
import 'package:cps_patient/presentation/styles/theme.dart';

class PasswordField extends StatefulWidget {
  final String labelText;
  final String? hintText;
  final TextEditingController? controller;

  const PasswordField({
    super.key,
    required this.labelText,
    this.hintText,
    this.controller,
  });

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        controller: widget.controller,
        obscureText: _obscureText,
        decoration: InputDecoration(
          labelText: widget.labelText,
          hintText: widget.hintText,
          prefixIcon: const Icon(Icons.lock),
          suffixIcon: IconButton(
            icon: Icon(
              _obscureText ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: _toggleVisibility,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          filled: true,
          fillColor: AppTheme.secondaryColor,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        ),
      ),
    );
  }
}
