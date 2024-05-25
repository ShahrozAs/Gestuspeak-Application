import 'package:flutter/material.dart';

class MyUserNameTextField extends StatefulWidget {
  final String hint;
  final String label;
  final bool obscureText;
  final TextEditingController controller;

  MyUserNameTextField({
    super.key,
    required this.hint,
    required this.label,
    required this.obscureText,
    required this.controller,
  });

  @override
  _MyUserNameTextFieldState createState() => _MyUserNameTextFieldState();
}

class _MyUserNameTextFieldState extends State<MyUserNameTextField> {
  String? errorText;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_validateUsername);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_validateUsername);
    super.dispose();
  }

  void _validateUsername() {
    final value = widget.controller.text;
    if (value.isEmpty) {
      setState(() {
        errorText = 'Please enter a username';
      });
    } else if (value.length <= 5) {
      setState(() {
        errorText = 'Username must be greater than 5 characters';
      });
    } else {
      final RegExp usernameRegex = RegExp(
        r'^[a-zA-Z0-9]+$',
      );
      if (!usernameRegex.hasMatch(value)) {
        setState(() {
          errorText = 'Username can only contain letters and digits';
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
