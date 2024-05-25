import 'package:GestuSpeak/components/my_TextFieldEmail.dart';
import 'package:GestuSpeak/themes/theme_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:GestuSpeak/components/my_Button.dart';
import 'package:GestuSpeak/components/my_TextField.dart';
import 'package:GestuSpeak/components/my_TextPasswordField.dart';
import 'package:GestuSpeak/helper/helper_functions.dart';
import 'package:GestuSpeak/pages/forgot_password_page.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  void Function()? onTap;
  LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailEditController = TextEditingController();

  TextEditingController passwordEditController = TextEditingController();

  void Login() async {
    performActionIfValid();
    // showDialog(
    //   context: context,
    //   builder: (context) {
    //     return Center(
    //       child: CircularProgressIndicator(),
    //     );
    //   },
    // );

    // try {
    //   await FirebaseAuth.instance.signInWithEmailAndPassword(
    //       email: emailEditController.text.trim(),
    //       password: passwordEditController.text.trim());

    //   if (context.mounted) Navigator.pop(context);
    // } on FirebaseAuthException catch (e) {
    //   Navigator.pop(context);
    //   displayMessageToUser(e.code, context);
    // }
  }

  void performActionIfValid() async{

  // // Validation for email
  final String email = emailEditController.text;
  if (email.isEmpty) {
    _showNotification('Please enter an email');
    return;
  } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(email)) {
    _showNotification('Please enter a valid email');
    return;
  }

  // Validation for password
  final String password = passwordEditController.text;
  if (password.isEmpty) {
    _showNotification('Please enter a password');
    return;
  } else if (password.contains(' ')) {
    _showNotification('Password must not contain spaces');
    return;
  } else if (password.length <= 6) {
    _showNotification('Password must be greater than 6 characters');
    return;
  } else if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*(),.?":{}|<>]).{6,}$').hasMatch(password)) {
    _showNotification('Password must contain lower, upper, digit, and special character');
    return;
  }

  // Validation for confirmPassword


  // If all validations pass, perform the desired action
  // For example, navigate to the next screen

      showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailEditController.text.trim(),
          password: passwordEditController.text.trim());

      if (context.mounted) Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      displayMessageToUser(e.code, context);
    }

}

void _showNotification(String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text("Login"),
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
                    Image.asset(
                      'assets/images/logo5r.png',
                      width: 130,
                      height: 130,
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Text("G E S T U S P E A K",
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge!
                            .copyWith(fontSize: 25)),
                    SizedBox(
                      height: 50,
                    ),
                    MyEmailTextField(
                        hint: "john@gmail.com",
                        label: "Username or Email",
                        obscureText: false,
                        controller: emailEditController),
                    SizedBox(
                      height: 10,
                    ),
                    MyPasswordField(
                        hint: "Password",
                        label: "Password",
                        controller: passwordEditController),
                    // MyTextField(hint: "Password", label: "Password", obscureText: true, controller:passwordEditController ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ForgotPasswordPage(),
                                  ));
                            },
                            child: const Text(
                              "Forgot Password?",
                              style: TextStyle(color: Color(0xff6B645D)),
                            )),
                      ],
                    ),

                    const SizedBox(
                      height: 25,
                    ),

                    MyButton(text: "Login", onTap: Login),
                    const SizedBox(
                      height: 25,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account?"),
                        GestureDetector(
                          onTap: widget.onTap,
                          child: const Text(
                            " Register Here",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
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
