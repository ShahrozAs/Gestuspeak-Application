import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:GestuSpeak/components/my_TextField.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    super.dispose();
  }

  Future passwordReset()async{
    try {
      
 await FirebaseAuth.instance.sendPasswordResetEmail(email:_emailController.text.trim() );
 showDialog(context: context, builder: (context) {
        return AlertDialog(content:  Text('Password reset Link sent! Check your email'),);
      },);
    }on FirebaseAuthException catch (e) {
      print(e);
      showDialog(context: context, builder: (context) {
        return AlertDialog(content:  Text(e.message.toString()),);
      },);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Text("Enter Your Email and we will send you a password reset link",textAlign: TextAlign.center,),
          ),
          SizedBox(height: 25,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: MyTextField(
                hint: "johndoe@gmail.com",
                label: "Email",
                obscureText: false,
                controller: _emailController),
          ),
          SizedBox(height: 15,),

          ElevatedButton(
            onPressed: () {passwordReset();},
            child: Text("Reset Password"),
            style: ElevatedButton.styleFrom(
              foregroundColor: Color(0xffFFCB2D),
              backgroundColor: Color(0xff6B6A5D),
            ),
          ),
        ],
      ),
    );
  }
}
