import 'package:GestuSpeak/themes/dark_mode.dart';
import 'package:GestuSpeak/themes/light_mode.dart';
import 'package:GestuSpeak/themes/theme_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:GestuSpeak/firebase_options.dart';

import 'package:GestuSpeak/pages/splash_page.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
   runApp(ChangeNotifierProvider(create: (context) => ThemeProvider(),
  child: const MyApp(),));
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GestuSpeak',
      // theme: ThemeData(
      //   colorScheme:ColorScheme.fromSeed(seedColor:const Color(0xff6B645D),), 
      // textTheme:const TextTheme(
      // headlineLarge: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Color(0xff6B645D))
      // ),
     
      // ),
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: const SplashPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
