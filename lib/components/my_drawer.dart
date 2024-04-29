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
                DrawerHeader(child: Image.asset('assets/images/logo5r.png',width: 110,height: 110,)),
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: ListTile(
                    title: Text("P E R S O N A L  I N F O",style: TextStyle(fontSize: 14),),
                    leading: Image.asset('assets/images/profile1.png',width: 30,),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage(),));
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: ListTile(
                    title: Text("E D I T  P R O F I L E",style: TextStyle(fontSize: 14),),
                     leading: Image.asset('assets/images/editprofile.png',width: 29,),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfilePage(),));
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: ListTile(
                    title: Text("U S E R  G U I D E",style: TextStyle(fontSize: 14),),
                       leading: Image.asset('assets/images/manual1.png',width: 30,),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(context,MaterialPageRoute(builder: (context) => UserGuidePage(),));
                    },
                  ),
                ),
              ],
            ),
        
              Padding(
                  padding: const EdgeInsets.only(left: 15.0,bottom: 25.0),
                  child: ListTile(
                    title: Text("L O G O U T",style: TextStyle(fontSize: 14),),
                       leading: Image.asset('assets/images/logout1.png',width: 35,),
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
