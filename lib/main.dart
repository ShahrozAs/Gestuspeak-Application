import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:gestuspeak/firebase_options.dart';

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
      title: 'GestuSpeak',
      theme: ThemeData(
        colorScheme:ColorScheme.fromSeed(seedColor:const Color(0xff6B645D),), 
      textTheme:const TextTheme(
      headlineLarge: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Color(0xff6B645D))
      )
     
      ),
      home: const SplashPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
