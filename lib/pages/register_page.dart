import 'package:GestuSpeak/themes/theme_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:GestuSpeak/components/my_Button.dart';
import 'package:GestuSpeak/components/my_TextField.dart';
import 'package:GestuSpeak/components/my_TextPasswordField.dart';
import 'package:GestuSpeak/helper/helper_functions.dart';
import 'package:provider/provider.dart';

class RegistorPage extends StatefulWidget {
  void Function()? onTap;
   RegistorPage({super.key,required this.onTap});

  @override
  State<RegistorPage> createState() => _RegistorPageState();
}

class _RegistorPageState extends State<RegistorPage> {
TextEditingController userEditController=TextEditingController();

TextEditingController emailEditController=TextEditingController();

TextEditingController passwordEditController=TextEditingController();

TextEditingController confirmPasswordEditController=TextEditingController();

void register()async{
  //show loading circle
  showDialog(context: context, builder: (context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  },);

 //match password
 if (passwordEditController.text!=confirmPasswordEditController.text) {
   Navigator.pop(context);
   displayMessageToUser("Password not match!",context);
 }

 //
else{

 try {
   UserCredential? userCredential=await FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailEditController.text.trim(), password: passwordEditController.text.trim());

   createUserDocument(userCredential);
   Navigator.pop(context);

 } on FirebaseAuthException catch (e) {
   Navigator.pop(context);
   displayMessageToUser(e.code, context);
   
 }
}

}

Future<void> createUserDocument(UserCredential? userCredential)async{
if (userCredential!=null && userCredential.user!=null) {
  await FirebaseFirestore.instance.collection("Users").doc(userCredential.user!.email).set({'email':userCredential.user!.email,
  'username':userEditController.text,
  'uid':userCredential.user!.uid,
  'userEmail':userCredential.user!.email,
  });
}
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      appBar: AppBar(
        // automaticallyImplyLeading: true,

        title: Text("Register"),

        actions: [
          Row(
            children: [
              Text("Dark Mode"),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: CupertinoSwitch(
                    value: Provider.of<ThemeProvider>(context, listen: false)
                        .isDarkMode,
                    onChanged: (value) {
                      Provider.of<ThemeProvider>(context, listen: false)
                          .toggleTheme();
                    }),
              ),
            ],
          ),
        ],
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
      ),
       body: Center(
         child: Container(
           child: SingleChildScrollView(
             child: Center(
               
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/logo5r.png',width: 130,height: 130,),
                    SizedBox(height: 25,),
                    Text("G E S T U S P E A K",style:Theme.of(context).textTheme.headlineLarge!.copyWith(fontSize: 25)),
                    SizedBox(height: 50,),
                    MyTextField(hint: "john doe", label: "Username", obscureText: false, controller:userEditController ),
                    SizedBox(height: 10,),
                    MyTextField(hint: "john@gmail.com", label: "Email", obscureText: false, controller:emailEditController ),
                    SizedBox(height: 10,),
                   MyPasswordField(hint: "Password", label: "Password", controller: passwordEditController),
                  
                    // MyTextField(hint: "Password", label: "Password", obscureText: true, controller:passwordEditController ),
                    SizedBox(height: 10,),
                   MyPasswordField(hint: "Confirm Password", label: "Confirm Password", controller: confirmPasswordEditController),
                  
                    // MyTextField(hint: "Password", label: "Confirm Password", obscureText: true, controller:confirmPasswordEditController ),
                    SizedBox(height: 10,),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.end,
                    //   children: [
                    //     Text("Forgot Password?",style: TextStyle(color:Color(0xff6B645D)),),
                    //   ],
                    // ),
             
                    SizedBox(height: 25,),
             
                    MyButton(text: "Register", onTap: register),
                    SizedBox(height: 25,),
             
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account?"),
                        GestureDetector(
                          onTap: widget.onTap,
                          child: Text(" Login Here",
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