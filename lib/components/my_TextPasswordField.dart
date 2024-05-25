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
  String? errorText;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_validatePassword);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_validatePassword);
    super.dispose();
  }

  void _validatePassword() {
    final value = widget.controller.text;

    if (value.isEmpty) {
      setState(() {
        errorText = 'Please enter a password';
      });
    } else if (value.contains(' ')) {
      setState(() {
        errorText = 'Password must not contain spaces';
      });
    } else if (value.length <= 6) {
      setState(() {
        errorText = 'Password must be greater than 6 characters';
      });
    } else {
      final RegExp lowerCaseRegex = RegExp(r'[a-z]');
      final RegExp upperCaseRegex = RegExp(r'[A-Z]');
      final RegExp digitRegex = RegExp(r'\d');
      final RegExp specialCharRegex = RegExp(r'[!@#$%^&*(),.?":{}|<>]');

      if (!lowerCaseRegex.hasMatch(value) ||
          !upperCaseRegex.hasMatch(value) ||
          !digitRegex.hasMatch(value) ||
          !specialCharRegex.hasMatch(value)) {
        setState(() {
          errorText = 'Password must contain lower, upper, digit, and special character';
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
      child: TextField(
        obscureText: isObscureText,
        controller: widget.controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          labelText: widget.label,
          hintText: widget.hint,
          errorText: errorText,
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
