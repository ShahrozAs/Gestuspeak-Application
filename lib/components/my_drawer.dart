import 'package:GestuSpeak/auth/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:GestuSpeak/pages/edit_profilePage.dart';
import 'package:GestuSpeak/pages/profile_page.dart';
import 'package:GestuSpeak/pages/user_guide.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                DrawerHeader(
                    child: Image.asset(
                  'assets/images/logo5r.png',
                  width: 110,
                  height: 110,
                )),
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: ListTile(
                    title: Text(
                      "P E R S O N A L  I N F O",
                      style: TextStyle(fontSize: 14),
                    ),
                    leading: Image.asset(
                      'assets/images/profile1.png',
                      width: 30,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfilePage(),
                          ));
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: ListTile(
                    title: Text(
                      "E D I T  P R O F I L E",
                      style: TextStyle(fontSize: 14),
                    ),
                    leading: Image.asset(
                      'assets/images/editprofile.png',
                      width: 29,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditProfilePage(),
                          ));
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: ListTile(
                    title: Text(
                      "U S E R  G U I D E",
                      style: TextStyle(fontSize: 14),
                    ),
                    leading: Image.asset(
                      'assets/images/manual1.png',
                      width: 30,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserGuidePage(),
                          ));
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, bottom: 25.0),
              child: ListTile(
                title: Text(
                  "L O G O U T",
                  style: TextStyle(fontSize: 14),
                ),
                leading: Image.asset(
                  'assets/images/logout1.png',
                  width: 35,
                ),
             onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Center(
                          child: Container(
                            width: 400, // Adjust the width as needed
                            // height: 500, // Adjust the height as needed
                            child: AlertDialog(
                              content: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      "Are you sure you want to logout?",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                    ),
                                  ),
                                  SizedBox(
                                      height:
                                          20), // Add spacing between text and buttons
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("No"),
                                        style: ElevatedButton.styleFrom(
                                          foregroundColor: Colors.white,
                                          backgroundColor: Colors.black,
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () async {
                                          await FirebaseAuth.instance.signOut();
                                          // Navigate to LoginOrRegister page after sign out
                                          Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AuthPage()),
                                            (route) =>
                                                false, // Remove all existing routes from the navigation stack
                                          );
                                        },
                                        child: Text("Yes"),
                                        style: ElevatedButton.styleFrom(
                                          foregroundColor: Colors.white,
                                          backgroundColor: Colors.red,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
