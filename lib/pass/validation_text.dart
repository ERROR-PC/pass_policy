import 'package:flutter/material.dart';

class ValidationText extends StatefulWidget {
  final String text;
  final bool isValid;

  const ValidationText({super.key, this.text = '', this.isValid = false});

  @override
  State<ValidationText> createState() => _ValidationTextState();
}

class _ValidationTextState extends State<ValidationText> {
  static const IconData _checkCircle = Icons.check_circle;
  Color _currColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    _currColor = widget.isValid ? Colors.green : Colors.grey;

    return Row(
      children: [
        Icon(
          _checkCircle,
          color: _currColor,
          size: 20,
        ),
        const SizedBox(width: 5),
        Expanded(
          child: Text(
            widget.text,
            style: TextStyle(color: _currColor),
            softWrap: true,
          ),
        ),
      ],
    );
  }
}
