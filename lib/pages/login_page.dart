import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gestuspeak/components/my_Button.dart';
import 'package:gestuspeak/components/my_TextField.dart';
import 'package:gestuspeak/helper/helper_functions.dart';

class LoginPage extends StatefulWidget {
  void Function()? onTap;
   LoginPage({super.key,required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
TextEditingController emailEditController=TextEditingController();

TextEditingController passwordEditController=TextEditingController();

 void Login()async{
  //show loading circle
  showDialog(context: context, builder: (context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  },);


 //

 try {
 await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailEditController.text, password: passwordEditController.text);

   if (context.mounted) Navigator.pop(context);
 } on FirebaseAuthException catch (e) {
   Navigator.pop(context);
   displayMessageToUser(e.code, context);
   
 }

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
       body: Center(
         child: Container(
           child: SingleChildScrollView(
             child: Center(
               
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/logo3r.png',width: 130,height: 130,),
                    SizedBox(height: 25,),
                    Text("G E S T U S P E A K",style:Theme.of(context).textTheme.headlineLarge),
                    SizedBox(height: 50,),
                    MyTextField(hint: "john@gmail.com", label: "Username or Email", obscureText: false, controller:emailEditController ),
                    SizedBox(height: 10,),
                    MyTextField(hint: "Password", label: "Password", obscureText: true, controller:passwordEditController ),
                    SizedBox(height: 10,),
                   Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                         Text("Forgot Password?",style: TextStyle(color:Color(0xff6B645D)),),
                      ],
                    ),
             
                   const SizedBox(height: 25,),
             
                    MyButton(text: "Login", onTap: Login),
                   const SizedBox(height: 25,),
             
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                       const Text("Don't have an account?"),
                        GestureDetector(
                          onTap: widget.onTap,
                          child:const Text(" Register Here",
                          style: TextStyle(
                            fontWeight: FontWeight.bold
                          ),),
                        )
                      ],
                    )
                    
                
                  ],
                ),
              ),
             ),
           ),
         ),
       ),
    );
  }
}