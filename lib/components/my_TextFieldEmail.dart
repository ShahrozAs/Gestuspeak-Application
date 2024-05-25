import 'package:flutter/material.dart';

class MyEmailTextField extends StatefulWidget {
  final String hint;
  final String label;
  final bool obscureText;
  final TextEditingController controller;

  MyEmailTextField({
    super.key,
    required this.hint,
    required this.label,
    required this.obscureText,
    required this.controller,
  });

  @override
  _MyEmailTextFieldState createState() => _MyEmailTextFieldState();
}

class _MyEmailTextFieldState extends State<MyEmailTextField> {
  String? errorText;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_validateEmail);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_validateEmail);
    super.dispose();
  }

  void _validateEmail() {
    final value = widget.controller.text;
    if (value.isEmpty) {
      setState(() {
        errorText = 'Please enter an email';
      });
    } else {
      final RegExp emailRegex = RegExp(
        r'^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]+$',  // Updated regex
      );
      if (!emailRegex.hasMatch(value)) {
        setState(() {
          errorText = 'Please enter a valid email with only English alphabets and digits';
        });
      } else {
        setState(() {
          errorText = null;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(left: 20,right: 20),
      child: TextField(
        obscureText: widget.obscureText,
        controller: widget.controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          labelText: widget.label,
          hintText: widget.hint,
          errorText: errorText,
        ),
      ),
    );
  }
}
