import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gestuspeak/components/my_drawer.dart';
import 'package:gestuspeak/helper/checkpPost.dart';
import 'package:gestuspeak/helper/showFavoriteNodes.dart';
import 'package:gestuspeak/pages/favorite_page.dart';
import 'package:gestuspeak/pages/home_page.dart';
import 'package:gestuspeak/pages/note_page.dart';

class FavoriteNotesPage extends StatelessWidget {
   FavoriteNotesPage({super.key});
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
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.toggle_on,
                color: Color(0xffFFCB2D),
              )),
      
        ],
        backgroundColor: Colors.white,
        elevation: 0.5,
      ),
      drawer:const MyDrawer(),
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
                      return ShowFavoriteNode(userEmail: user?['userEmail']??"");
                       } else {
                      return Center(
                        child: Text("No Data Found"),
                      );
                    }
                  }),
            ],
          )),
                  
                  
      
         
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Color(0xffFFCB2D),
        unselectedItemColor: Color(0xff6B645D),
        
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.pending_actions_outlined),
            label: 'Notes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline_rounded),
            label: 'favourite',
          ),
        ],

        currentIndex: 2, // Set the initial index to Home
        onTap: (index) {
          // Handle navigation on item tap
          switch (index) {
            case 0:
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NotePage(),
                  ));
              // Navigator.pushNamed(context, homeScreenRoute);
              break;
            case 1:
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ));
              // Navigator.pushNamed(context, searchScreenRoute);
              break;
            case 2:
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FavoriteNotesPage(),
                  ));
              // Navigator.pushNamed(context, uploadScreenRoute);
              break;
            case 3:
              // Navigator.pushNamed(context, videosScreenRoute);
              break;
       
          }
        },
      ),

    );
  }
}
