import 'package:flutter/material.dart';

class MyPasswordField extends StatefulWidget {
  final String hint;
  final String label;
  final TextEditingController controller;

  MyPasswordField({
    Key? key,
    required this.hint,
    required this.label,
    required this.controller,
  }) : super(key: key);

  @override
  _MyPasswordFieldState createState() => _MyPasswordFieldState();
}

class _MyPasswordFieldState extends State<MyPasswordField> {
  bool isObscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        obscureText: isObscureText,
        controller: widget.controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          labelText: widget.label,
          hintText: widget.hint,
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                isObscureText = !isObscureText;
              });
            },
            icon: Icon(
              isObscureText ? Icons.visibility_off : Icons.visibility,
            ),
          ),
        ),
      ),
    );
  }
}
