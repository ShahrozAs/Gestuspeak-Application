import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gestuspeak/pages/edit_profilePage.dart';
import 'package:gestuspeak/pages/profile_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
    
      backgroundColor: Color(0xffF2F2F2),
      child: Padding(
        padding: const EdgeInsets.only(left:25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                DrawerHeader(child: Image.asset('assets/images/logo3r.png',width: 120,height: 120,)),
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: ListTile(
                    title: Text("P E R S O N A L  I N F O"),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage(),));
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: ListTile(
                    title: Text("E D I T  P R O F I L E"),
                    onTap: () {
                      Navigator.pop(context);
                       Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfilePage(),));
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: ListTile(
                    title: Text("A B O U T"),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
        
              Padding(
                  padding: const EdgeInsets.only(left: 25.0,bottom: 25.0),
                  child: ListTile(
                    title: Text("L O G O U T"),
                    onTap: () {
                      Navigator.pop(context);
                
                      FirebaseAuth.instance.signOut();
                    },
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
