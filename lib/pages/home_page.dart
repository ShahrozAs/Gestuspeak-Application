import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gestuspeak/components/my_drawer.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  bool isSelect = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      appBar: AppBar(
        backgroundColor: Color(0xffF2F2F2),
        elevation: 0,
      ),
      drawer: MyDrawer(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              width: double.infinity,
              height: 300,
              child: Image.asset(
                'assets/images/hand.jpg',
                fit: BoxFit.contain,
                height: null,
                width: null,
                // height: 32,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
                
              ),
            )
          ]),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xffF2F2F2),
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

        currentIndex: 1, // Set the initial index to Home
        onTap: (index) {
          // Handle navigation on item tap
          switch (index) {
            case 0:
              // Navigator.pushNamed(context, homeScreenRoute);
              break;
            case 1:
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => SearchPage(),
              //     ));
              // Navigator.pushNamed(context, searchScreenRoute);
              break;
            case 2:
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => UploadPostPage(),
              //     ));
              // Navigator.pushNamed(context, uploadScreenRoute);
              break;
            case 3:
              // Navigator.pushNamed(context, videosScreenRoute);
              break;
            // case 4:
            //   // Navigator.pushNamed(context, profileScreenRoute);
            //   // Navigator.push(
            //   //     context,
            //   //     MaterialPageRoute(
            //   //       builder: (context) => ProfilePage(),
            //   //     ));
            //   break;
          }
        },
      ),
    );
  }
}
