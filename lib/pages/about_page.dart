import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text("About"),
      ),
      body: (
        Center(
          child: Padding(padding: 
          EdgeInsets.all(20),
          child: Column(),
          ),
        )
      ),
    );
  }
}