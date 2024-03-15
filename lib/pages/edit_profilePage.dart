import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gestuspeak/helper/resources.dart';
import 'package:gestuspeak/pages/favorite_page.dart';
import 'package:gestuspeak/pages/home_page.dart';
import 'package:gestuspeak/pages/note_page.dart';
import 'package:gestuspeak/pages/upload_image.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:instagram_clone/helper/resources.dart';
// import 'package:instagram_clone/pages/upload_image.dart';

// Other necessary imports for image picker, storage, network, etc.

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  // Variables to store profile data from state management
  String profileImagePath = "";
  String username = "";
  String name = "";
  String live = "";
  String about = "";
  String pronouns = "";
  String gender = "";

  // // Function to handle image selection
  // Future<void> pickImage() async {
  //   // Implement image picker functionality
  // }

  // Function to handle profile update
  // Future<void> updateProfile() async {
  //   // Implement profile update logic with server/database
  // }

  void saveProfile()async{
    showDialog(context: context, builder: (context) {
      return const Center(child: AlertDialog(actions: [Center(child: CircularProgressIndicator()),],title: Center(child: Text("Saving.."))),);
    },);
    String resp=await storeData().saveData(name: name, username: username, about: about,live: live, file: _image!);


     Navigator.pop(context);

     Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(),));
  }

  Uint8List? _image;

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Edit Profile'),
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // Profile picture widget with image selection
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: selectImage,
                    child: _image != null
                        ? Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: CircleAvatar(
                              radius: 90,
                              backgroundImage: MemoryImage(
                                (_image!),
                              ),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: CircleAvatar(
                              radius: 90,
                              foregroundImage: AssetImage(
                                "assets/images/profile.png",
                              ),
                            ),
                          ),
                  ),
                  // SizedBox(
                  //   width: 20,
                  // ),
                  // CircleAvatar(
                  //   radius: 50,
                  //   backgroundImage: profileImagePath.isNotEmpty
                  //       ? FileImage(File(profileImagePath))
                  //       : null,
                  //   child: IconButton(
                  //     icon: Icon(Icons.face_retouching_natural_outlined),
                  //     onPressed: () {},
                  //   ),
                  // ),
                ],
              ),

              SizedBox(height: 20),
              Center(
                child: Text(
                  "Edit picture or avatar",
                  style: TextStyle(fontSize: 15, color: Colors.blue[500]),
                ),
              ),
              SizedBox(height: 20),
              // Text fields for name, username, live, about, and pronouns
              TextFormField(
                initialValue: name,
                decoration: InputDecoration(labelText: 'Name'),
                onChanged: (value) => setState(() => name = value),
              ),
              TextFormField(
                initialValue: username,
                decoration: InputDecoration(labelText: 'Username'),
                onChanged: (value) => setState(() => username = value),
              ),
              TextFormField(
                initialValue: live,
                decoration: InputDecoration(labelText: 'live in'),
                onChanged: (value) => setState(() => live = value),
              ),
              TextFormField(
                initialValue: about,
                decoration: InputDecoration(labelText: 'About'),
                onChanged: (value) => setState(() => about = value),
                maxLines: 5, // Allow multiple lines for about
              ),
          
              // Gender selection
              Row(
                children: [
                  Text('Gender:'),
                  SizedBox(width: 10),
                  // Radio buttons for common options
                  Row(
                    children: [
                      Radio<String>(
                        value: 'male',
                        groupValue: gender,
                        onChanged: (value) => setState(() => gender = value!),
                      ),
                      Text('Male'),
                      SizedBox(width: 10),
                      Radio<String>(
                        value: 'female',
                        groupValue: gender,
                        onChanged: (value) => setState(() => gender = value!),
                      ),
                      Text('Female'),
                    ],
                  ),
                  // Additional option for custom gender
                  Radio<String>(
                    value: 'other',
                    groupValue: gender,
                    onChanged: (value) => setState(() => gender = value!),
                  ),
                  Text('Other'),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: saveProfile,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text('Save'),
                  ),
                  style: ElevatedButton.styleFrom(
                      foregroundColor: Color(0xffFFCB2D),backgroundColor: Color(0xff6B6A5D),
                ),
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

        currentIndex: 1, // Set the initial index to Home
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
