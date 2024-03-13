import 'package:flutter/material.dart';
import 'package:gestuspeak/components/my_bottomNavigation.dart';
import 'package:gestuspeak/components/my_drawer.dart';
import 'package:gestuspeak/pages/favorite_page.dart';
import 'package:gestuspeak/pages/home_page.dart';
import 'package:gestuspeak/pages/more_notespage.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Color(0xffF2F2F2),
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.toggle_on,
                color: Color(0xffFFCB2D),
              )),
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: CircleAvatar(
                backgroundColor: Color(0xffF2F2F2),
                radius: 20,
                child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.logout,
                      color: Color(0xffFFCB2D),
                    ))),
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      drawer: MyDrawer(),
      body: SingleChildScrollView(

      
        
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
                width: double.infinity,
                
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color(0xffF2F2F2),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Image.asset(
                                'assets/images/profile.png',
                                width: 150,
                                height: 150,
                              ),
                            ),
                          ),
                          Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color(0xffF2F2F2),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Dummy Text",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineLarge!.copyWith(fontSize: 18),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        IconButton(
                                            onPressed: () {},
                                            icon: Icon(Icons.speaker)),
                                      ],
                                    )
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

                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        child: TextField(
                          
                          decoration: InputDecoration(
                            suffixIcon: Icon(Icons.send),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              hintText: "Search Text",
                              labelText: "Search"),
                              
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),

              Container(
             height: 315,
                width: double.infinity,
                padding: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12), color: Colors.white),
               
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                  
                      Container(
                        height: 3.0,
                        width: 40,
                        color: Colors.black,
                      ),
                      SizedBox(height: 20,),
                  
                    Expanded(
                      child: ListView.builder(itemBuilder: (context, index) {
                        return Container(
                          
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Color(0xffF2F2F2)),
                          width: double.infinity,
                          margin: EdgeInsets.only(left:10,right: 10,bottom: 10),
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                
                                  "This App is Under Developement...",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(fontSize: 15),
                                ),
                                Icon(Icons.speaker),
                              ],
                            ),
                          ),
                        );
                      },itemCount: 3,),
                    ),


                          SizedBox(height: 15,),
                          ElevatedButton(onPressed: (){ Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MoreNotesPage(),
                      ));}, child:Text("See more"),style: ElevatedButton.styleFrom(
                              foregroundColor: Color(0xffFFCB2D),backgroundColor: Color(0xff6B6A5D),
                            ),)
                          
                    ],
                  ),
                
              )
            ],
          ),
        ),
        
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

        currentIndex: 0, // Set the initial index to Home
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
