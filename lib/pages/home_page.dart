import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gestuspeak/components/my_drawer.dart';
import 'package:gestuspeak/pages/favorite_page.dart';
import 'package:gestuspeak/pages/more_notespage.dart';
import 'package:gestuspeak/pages/note_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  bool isSelect = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      appBar: AppBar(
        actions: [

           IconButton(onPressed: (){},icon: Icon(Icons.toggle_on,color: Color(0xffFFCB2D),)),
           Padding(
             padding: const EdgeInsets.only(right:10.0),
             child: CircleAvatar(backgroundColor: Color(0xffF2F2F2),radius: 20,child: IconButton(onPressed: (){},icon: Icon(Icons.logout,color: Color(0xffFFCB2D),))),
           ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      drawer: MyDrawer(),
      body: 
       Padding(
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
                height: 480,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),

                child: Column(
                  children: [
                     Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),color: Color(0xffF2F2F2)),
                      width: double.infinity,
                    
                       margin: EdgeInsets.all(10),
                       height: 250,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text("This App is Under Developement",style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 23),),
                      ) ,
                     ),
                     Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),color: Color(0xffF2F2F2)),
                      width: double.infinity,
                    
                       margin: EdgeInsets.all(10),
                     
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text("This App is Under Developement",style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 18),),
                      ) ,
                     ),
                     Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),color: Color(0xffF2F2F2)),
                      width: double.infinity,
                    
                       margin: EdgeInsets.all(10),
                     
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text("This App is Under Developement",style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 18),),
                      ) ,
                     ),
                  
                        ElevatedButton(onPressed: (){   Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NotePage(),
                  ));}, child:Text("Add note"),style: ElevatedButton.styleFrom(
                          foregroundColor: Color(0xffFFCB2D),backgroundColor: Color(0xff6B6A5D),
                        ),)
                  ],
                ),
                
              )
            ]),
          ),
      
      
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

        currentIndex: 1, // Set the initial index to Home
        onTap: (index) {
          // Handle navigation on item tap
          switch (index) {
            case 0:
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MoreNotesPage(),
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
