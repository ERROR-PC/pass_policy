import 'package:flutter/material.dart';

class PassFormField extends StatefulWidget {
  final String label;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;

  const PassFormField(
      {super.key, this.label = '', this.validator, this.onChanged});

  @override
  State<PassFormField> createState() => _PassFormFieldState();
}

class _PassFormFieldState extends State<PassFormField> {
  bool _obscureText = true;
  static const BorderRadius _borderRadius = BorderRadius.all(
    Radius.circular(5),
  );

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autocorrect: false,
      obscureText: _obscureText,
      onChanged: widget.onChanged,
      validator: widget.validator,
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: const TextStyle(color: Colors.black),
        border: const OutlineInputBorder(
          borderRadius: _borderRadius,
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
          borderRadius: _borderRadius,
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
          borderRadius: _borderRadius,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
            color: Colors.black,
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
      ),
    );
  }
}
