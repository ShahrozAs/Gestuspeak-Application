import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gestuspeak/auth/auth.dart';
import 'package:gestuspeak/auth/login_or_register.dart';
import 'package:gestuspeak/firebase_options.dart';
import 'package:gestuspeak/pages/login_page.dart';
import 'package:gestuspeak/pages/register_page.dart';
import 'package:gestuspeak/pages/splash_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme:ColorScheme.fromSeed(seedColor: Color(0xff6B645D),), 
      textTheme: TextTheme(
      headlineLarge: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Color(0xff6B645D))
      )
     
      ),
      home:  AuthPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
