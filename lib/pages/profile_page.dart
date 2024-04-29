import 'dart:typed_data';

import 'package:GestuSpeak/components/full_image.dart';
import 'package:GestuSpeak/themes/theme_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:GestuSpeak/components/my_drawer.dart';
import 'package:GestuSpeak/helper/checkpPost.dart';
import 'package:GestuSpeak/pages/favorite_page.dart';
import 'package:GestuSpeak/pages/home_page.dart';
import 'package:GestuSpeak/pages/note_page.dart';
import 'package:GestuSpeak/pages/upload_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final User? currentUser = FirebaseAuth.instance.currentUser!;

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetails() async {
    return await FirebaseFirestore.instance
        .collection('Users')
        .doc(currentUser!.email)
        .get();
  }


  @override
  Widget build(BuildContext context) {
    // Replace with actual user data
    final String userImage = 'assets/images/profile_image.png';
    final String userName = 'John Doe';
    final String userLocation = 'New York, USA';
    final DateTime userDateOfBirth = DateTime(1990, 1, 1);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary, // Light background for modern look
appBar: AppBar(
  title: Text("Personal Info"),
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
      // drawer: MyDrawer(),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              future: getUserDetails(),
              builder: (context, snapshot) {
                //during loading
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text("Error :${snapshot.error}"),
                  );
                } else if (snapshot.hasData) {
                  Map<String, dynamic>? user = snapshot.data!.data();
                  return Column(
                    children: [
                      InkWell(
                        onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => FullImagePreview(imageUrl: user?['imageLink'] ?? "https://www.moroccoupclose.com/uwagreec/2018/12/default_avatar-2048x2048.png"),));},
                        child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: CircleAvatar(
                                  radius: 90,
                                  foregroundImage: NetworkImage(
                                      '${user?['imageLink'] ?? "https://www.moroccoupclose.com/uwagreec/2018/12/default_avatar-2048x2048.png"}'
                                      //  "${user['imageLink']}"
                                      ),
                                ),
                              ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        user?['username'] ?? "username",
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const Divider(
                        height: 30,
                        thickness: 1,
                        indent: 50,
                        endIndent: 50,
                        color: Colors.grey,
                      ),
                      // Choose which information to display (location or date of birth)
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Theme.of(context).colorScheme.background),
                          margin: EdgeInsets.only(top: 25),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Name:", // Or format userDateOfBirth as desired
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 28,
                                    ),
                                    Text(user?['name'] ?? "null"),
                                  ],
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      "Live in:", // Or format userDateOfBirth as desired
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(width: 25),
                                    Expanded(
                                      child: Text(
                                        user?['live'] ?? "null",
                                        softWrap: true,
                                        // Other text styling properties can be added here
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      "About:", // Or format userDateOfBirth as desired
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(width: 28),
                                    Expanded(
                                      child: Text(
                                        user?['about'] ?? "null",
                                        softWrap: true,
                                        // Other text styling properties can be added here
                                      ),
                                    ),
                                  ],
                                ),
                               
                          
                              ],
                              
                            ),
                            
                          ),
                          
                        ),
                      ),
                    ],
                  );
                } else {
                  return Center(
                    child: Text("No Data Found"),
                  );
                }
              })),

      // bottomNavigationBar: BottomNavigationBar(
      //   backgroundColor: Theme.of(context).colorScheme.background,
      //   selectedItemColor: Color(0xffFFCB2D),
      //   // unselectedItemColor: Color(0xff6B645D),

      //   showSelectedLabels: true,
      //   showUnselectedLabels: true,
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.pending_actions_outlined),
      //       label: 'Notes',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: 'Home',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.favorite_outline_rounded),
      //       label: 'favourite',
      //     ),
      //   ],

      //   currentIndex: 1, // Set the initial index to Home
      //   onTap: (index) {
      //     // Handle navigation on item tap
      //     switch (index) {
      //       case 0:
      //         Navigator.pushReplacement(
      //             context,
      //             MaterialPageRoute(
      //               builder: (context) => NotePage(),
      //             ));
      //         // Navigator.pushNamed(context, homeScreenRoute);
      //         break;
      //       case 1:
      //         Navigator.pushReplacement(
      //             context,
      //             MaterialPageRoute(
      //               builder: (context) => HomePage(),
      //             ));
      //         // Navigator.pushNamed(context, searchScreenRoute);
      //         break;
      //       case 2:
      //         Navigator.pushReplacement(
      //             context,
      //             MaterialPageRoute(
      //               builder: (context) => FavoriteNotesPage(),
      //             ));
      //         // Navigator.pushNamed(context, uploadScreenRoute);
      //         break;
      //       case 3:
      //         // Navigator.pushNamed(context, videosScreenRoute);
      //         break;
      //     }
      //   },
      // ),
    );
  }
}
