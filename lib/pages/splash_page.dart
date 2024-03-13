import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gestuspeak/auth/auth.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {

    super.initState();
    Timer(const Duration(seconds: 3), () { Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>const AuthPage(),));});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff2f2f2),
      body: Center(child: Image.asset('assets/images/logo5r.png',width: 130,height: 130,),),
    );
  }
}