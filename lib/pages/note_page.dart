import 'dart:typed_data';

import 'package:GestuSpeak/themes/theme_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:GestuSpeak/components/full_image.dart';
import 'package:GestuSpeak/components/my_bottomNavigation.dart';
import 'package:GestuSpeak/components/my_drawer.dart';
import 'package:GestuSpeak/helper/checkpPost.dart';
import 'package:GestuSpeak/helper/searchNode.dart';
import 'package:GestuSpeak/helper/showOneNodeOnly.dart';
import 'package:GestuSpeak/pages/favorite_page.dart';
import 'package:GestuSpeak/pages/home_page.dart';
import 'package:GestuSpeak/pages/more_notespage.dart';
import 'package:GestuSpeak/pages/search_page.dart';
import 'package:GestuSpeak/pages/upload_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  final User? currentUser = FirebaseAuth.instance.currentUser!;

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetails() async {
    return await FirebaseFirestore.instance
        .collection('Users')
        .doc(currentUser!.email)
        .get();
  }


  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).colorScheme.secondary,
      appBar: AppBar(
        // leading: InkWell(onTap: (){Navigator.pop(context);},child: Icon(Icons.arrow_back_ios_new)),
        automaticallyImplyLeading: true,
        title: Text("Notes"),
        actions: [
          Row(children: [
            Text("Dark Mode"),
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: CupertinoSwitch(value: Provider.of<ThemeProvider>(context,listen: false).isDarkMode, onChanged: (value){
               Provider.of<ThemeProvider>(context,listen: false).toggleTheme();
            }),
          ),
    
          ],),
   
        ],
        backgroundColor:Theme.of(context).colorScheme.background,
        elevation: 0,
      ),
      // drawer: MyDrawer(),
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                        future: getUserDetails(),
                        builder: (context, snapshot) {
                          //during loading
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Text("Error :${snapshot.error}"),
                            );
                          } else if (snapshot.hasData) {
                            Map<String, dynamic>? user = snapshot.data!.data();
                            return Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color:Theme.of(context).colorScheme.background,
                                    ),
                                    width: double.infinity,
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              InkWell(
                                                onTap:(){
                                                  Navigator.push(context, MaterialPageRoute(builder: (context) => FullImagePreview(imageUrl: user?['imageLink']??"https://www.moroccoupclose.com/uwagreec/2018/12/default_avatar-2048x2048.png"),));
                                                },
                                                child:Padding(
                                                        padding:
                                                            const EdgeInsets.all(
                                                                10.0),
                                                        child: CircleAvatar(
                                                          radius: 60,
                                                          backgroundColor:
                                                              Theme.of(context).colorScheme.secondary,
                                                          foregroundImage: NetworkImage(
                                                              '${user?['imageLink'] ?? "https://www.moroccoupclose.com/uwagreec/2018/12/default_avatar-2048x2048.png"}'
                                                              //  "${user['imageLink']}"
                                                              ),
                                                        ),
                                                      ),
                                              ),
                                              Container(
                                                width: 150,
                                                height: 150,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  color:Theme.of(context).colorScheme.secondary,
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(0.0),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(
                                                        10.0),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        ShowOneNode(
                                                            userEmail: user?[
                                                                    'userEmail'] ??
                                                                ""),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 25,
                                          ),
                                          InkWell(
                                            onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => SearchNode(),));},
                                            child: Container(
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                color: Theme.of(context).colorScheme.secondary,
                                                  borderRadius:
                                                      BorderRadius.circular(20),border: Border.all(width: 1,color: Colors.black)),
                                              child:Padding(
                                                padding: const EdgeInsets.all(7.0),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(left:8.0),
                                                      child: Text("Search",),
                                                    ),
                                                    IconButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => SearchNode(),));}, icon:Icon(Icons.send))
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                    
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                    height: 300,
                                    width: double.infinity,
                                    padding: EdgeInsets.only(bottom: 10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: Theme.of(context).colorScheme.background),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Container(
                                          height: 3.0,
                                          width: 40,
                                          color: Theme.of(context).colorScheme.secondary,
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        ShowPost(
                                            userEmail: user?['userEmail'] ?? ""),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      MoreNotesPage(),
                                                ));
                                          },
                                          child: Text("See more"),
                                          style: ElevatedButton.styleFrom(
                                            foregroundColor: Color(0xffFFCB2D),
                                            backgroundColor: Color(0xff6B6A5D),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          } else {
                            return Center(
                              child: Text("No Data Found"),
                            );
                          }
                        })),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        selectedItemColor: Color(0xffFFCB2D),
        // unselectedItemColor: Color(0xff6B645D),

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

        currentIndex: 0, // Set the initial index to Home
        onTap: (index) {
          // Handle navigation on item tap
          switch (index) {
            case 0:
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NotePage(),
                  ));
              // Navigator.pushNamed(context, homeScreenRoute);
              break;
            case 1:
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ));
              // Navigator.pushNamed(context, searchScreenRoute);
              break;
            case 2:
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FavoriteNotesPage(),
                  ));
              // Navigator.pushNamed(context, uploadScreenRoute);
              break;
          }
        },
      ),
    );
  }
}







// import 'package:flutter/material.dart';
// import 'package:GestuSpeak/components/my_bottomNavigation.dart';
// import 'package:GestuSpeak/components/my_drawer.dart';
// import 'package:GestuSpeak/pages/favorite_page.dart';
// import 'package:GestuSpeak/pages/home_page.dart';
// import 'package:GestuSpeak/pages/more_notespage.dart';

// class NotePage extends StatefulWidget {
//   const NotePage({super.key});

//   @override
//   State<NotePage> createState() => _NotePageState();
// }

// class _NotePageState extends State<NotePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       backgroundColor: Color(0xffF2F2F2),
//       appBar: AppBar(
//         actions: [
//           IconButton(
//               onPressed: () {},
//               icon: Icon(
//                 Icons.toggle_on,
//                 color: Color(0xffFFCB2D),
//               )),
//           Padding(
//             padding: const EdgeInsets.only(right: 10.0),
//             child: CircleAvatar(
//                 backgroundColor: Color(0xffF2F2F2),
//                 radius: 20,
//                 child: IconButton(
//                     onPressed: () {},
//                     icon: Icon(
//                       Icons.logout,
//                       color: Color(0xffFFCB2D),
//                     ))),
//           ),
//         ],
//         backgroundColor: Colors.white,
//         elevation: 0,
//       ),
//       drawer: MyDrawer(),
//       body: SingleChildScrollView(

      
        
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             children: [
//               Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(12),
//                   color: Colors.white,
//                 ),
//                 width: double.infinity,
                
//                 child: Padding(
//                   padding: const EdgeInsets.all(20.0),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Container(
//                             width: 150,
//                             height: 150,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(20),
//                               color: Color(0xffF2F2F2),
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.all(0.0),
//                               child: Image.asset(
//                                 'assets/images/profile.png',
//                                 width: 150,
//                                 height: 150,
//                               ),
//                             ),
//                           ),
//                           Container(
//                             width: 150,
//                             height: 150,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(20),
//                               color: Color(0xffF2F2F2),
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.all(0.0),
//                               child: Padding(
//                                 padding: const EdgeInsets.all(10.0),
//                                 child: Column(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       "Dummy Text",
//                                       style: Theme.of(context)
//                                           .textTheme
//                                           .headlineLarge!.copyWith(fontSize: 18),
//                                     ),
//                                     Row(
//                                       mainAxisAlignment: MainAxisAlignment.end,
//                                       children: [
//                                         IconButton(
//                                             onPressed: () {},
//                                             icon: Icon(Icons.speaker)),
//                                       ],
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                        SizedBox(
//                 height: 25,
//               ),

//                       Container(
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(20)),
//                         child: TextField(
                          
//                           decoration: InputDecoration(
//                             suffixIcon: Icon(Icons.send),
//                               border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(20)),
//                               hintText: "Search Text",
//                               labelText: "Search"),
                              
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 15,
//               ),

//               Container(
//              height: 315,
//                 width: double.infinity,
//                 padding: EdgeInsets.only(bottom: 10),
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(12), color: Colors.white),
               
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       SizedBox(
//                         height: 20,
//                       ),
                  
//                       Container(
//                         height: 3.0,
//                         width: 40,
//                         color: Colors.black,
//                       ),
//                       SizedBox(height: 20,),
                  
//                     Expanded(
//                       child: ListView.builder(itemBuilder: (context, index) {
//                         return Container(
                          
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(12),
//                               color: Color(0xffF2F2F2)),
//                           width: double.infinity,
//                           margin: EdgeInsets.only(left:10,right: 10,bottom: 10),
//                           child: Padding(
//                             padding: const EdgeInsets.all(18.0),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Text(
                                
//                                   "This App is Under Developement...",
//                                   style: Theme.of(context)
//                                       .textTheme
//                                       .bodyLarge!
//                                       .copyWith(fontSize: 15),
//                                 ),
//                                 Icon(Icons.speaker),
//                               ],
//                             ),
//                           ),
//                         );
//                       },itemCount: 3,),
//                     ),


//                           SizedBox(height: 15,),
//                           ElevatedButton(onPressed: (){ Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => MoreNotesPage(),
//                       ));}, child:Text("See more"),style: ElevatedButton.styleFrom(
//                               foregroundColor: Color(0xffFFCB2D),backgroundColor: Color(0xff6B6A5D),
//                             ),)
                          
//                     ],
//                   ),
                
//               )
//             ],
//           ),
//         ),
        
//       ),
        
//       bottomNavigationBar: BottomNavigationBar(
//         backgroundColor: Colors.white,
//         selectedItemColor: Color(0xffFFCB2D),
//         unselectedItemColor: Color(0xff6B645D),

//         showSelectedLabels: true,
//         showUnselectedLabels: true,
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.pending_actions_outlined),
//             label: 'Notes',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.favorite_outline_rounded),
//             label: 'favourite',
//           ),
//         ],

//         currentIndex: 0, // Set the initial index to Home
//         onTap: (index) {
//           // Handle navigation on item tap
//           switch (index) {
//             case 0:
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => NotePage(),
//                   ));
//               // Navigator.pushNamed(context, homeScreenRoute);
//               break;
//             case 1:
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => HomePage(),
//                   ));
//               // Navigator.pushNamed(context, searchScreenRoute);
//               break;
//             case 2:
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => FavoriteNotesPage(),
//                   ));
//               // Navigator.pushNamed(context, uploadScreenRoute);
//               break;
//             case 3:
//               // Navigator.pushNamed(context, videosScreenRoute);
//               break;
       
//           }
//         },
//       ),
//     );
//   }
// }
