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
import 'package:provider/provider.dart';

class MoreNotesPage extends StatelessWidget {
   MoreNotesPage({super.key});
   final User? currentUser = FirebaseAuth.instance.currentUser!;

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetails() async {
    return await FirebaseFirestore.instance
        .collection('Users')
        .doc(currentUser!.email)
        .get();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      automaticallyImplyLeading: true,
      
      title: Text("All Notes"),
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
      // drawer:const MyDrawer(),
      body:  Padding(
          padding: const EdgeInsets.all(20.0),
          child:  Column(
            children: [
              FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
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
                      return ShowPost(userEmail: user?['userEmail']??"");
                       } else {
                      return Center(
                        child: Text("No Data Found"),
                      );
                    }
                  }),
            ],
          )),
                  
                  
      
         
      // bottomNavigationBar: BottomNavigationBar(
      //   backgroundColor:Theme.of(context).colorScheme.background,
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

      //   currentIndex: 0, // Set the initial index to Home
      //   onTap: (index) {
      //     // Handle navigation on item tap
      //     switch (index) {
      //       case 0:
      //           Navigator.pushReplacement(
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
