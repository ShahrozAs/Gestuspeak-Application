import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gestuspeak/auth/auth.dart';
import 'package:gestuspeak/pages/login_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {

    super.initState();
    Timer(const Duration(seconds: 3), () { Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AuthPage(),));});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      body: Center(child: Image.asset('assets/images/logo5r.png',width: 130,height: 130,),),
    );
  }
}