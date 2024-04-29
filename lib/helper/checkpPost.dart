// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class ShowPost extends StatelessWidget {
//   final String userEmail;
//   ShowPost({Key? key, required this.userEmail}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return
//        Container(
//       height: 70,
//          child: Padding(
//           padding: EdgeInsets.all(0),
//           child: StreamBuilder(
//             stream: FirebaseFirestore.instance
//                 .collection('UsersVoiceNodes')
//                 .where('userEmail', isEqualTo: userEmail)
//                 .snapshots(),
//             builder: (BuildContext context,
//                 AsyncSnapshot<QuerySnapshot> snapshot) {
//               if (snapshot.hasError) {
//                 return _buildErrorMessage("Something went wrong");
//               }
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return Center(
//                   child: CircularProgressIndicator(),
//                 );
//               }
//               if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
//                 return _buildErrorMessage("No data found");
//               }
//                 return GridView.builder(
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 1,
//               crossAxisSpacing: 2.0,
//               mainAxisSpacing: 2.0,
//             ),
//             itemCount: snapshot.data!.docs.length,
//             itemBuilder: (BuildContext context, int index) {
//               DocumentSnapshot nodes = snapshot.data!.docs[index];
//               Map<String, dynamic> nodeData =
//                   nodes.data() as Map<String, dynamic>;
//               String node = nodeData['nodes'] ?? '';
//               print("helllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllo$node");

//               return GestureDetector(
//                 onTap: () {
//                   // Handle post click

//                 },
//                 child: Card(
//                     elevation: 0.5,
//                     child: Container(
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(12),
//                           color: const Color(0xffF2F2F2)),
//                       width: double.infinity,
//                       // margin: EdgeInsets.only(left: 10, right: 10),
//                       child: Padding(
//                         padding:
//                             const EdgeInsets.only(left: 10.0, right: 10.0, top: 10),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               node,
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .bodyLarge!
//                                   .copyWith(fontSize: 15),
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: [
//                                 IconButton(
//                                     onPressed: () {},
//                                     icon: Icon(Icons.favorite_border_rounded)),
//                                 IconButton(onPressed: () {}, icon: Icon(Icons.speaker))
//                                     ,  IconButton(onPressed: () {}, icon: Icon(Icons.more_vert_rounded))
//                               ],
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),

//               );
//             },
//           );
//             },
//           ),
//                ),
//        );

//   }

//   Widget _buildErrorMessage(String message) {
//     return Center(
//       child: Text(
//         message,
//         style: TextStyle(fontSize: 18.0),
//       ),
//     );
//   }
// }

// Work fine by adding delete functionailty

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_tts/flutter_tts.dart';
// import 'package:GestuSpeak/helper/resources.dart';

// class ShowPost extends StatelessWidget {
//   final String userEmail;

//   ShowPost({Key? key, required this.userEmail}) : super(key: key);

//   final FlutterTts flutterTts = FlutterTts();

// Future<void> _speak(String text) async {
//   await flutterTts.setVolume(1.0);
//   await flutterTts.setSpeechRate(0.5);
//   await flutterTts.setPitch(1.0);
//   await flutterTts.setLanguage("en-US");
//   await flutterTts.speak(text);
// }

//   @override
//   Widget build(BuildContext context) {
// void saveFavoriteVoiceNode(String node, bool isFavorite) async {
//   try {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return const Center(
//           child: AlertDialog(
//             actions: [Center(child: CircularProgressIndicator())],
//             title: Center(child: Text("Saving..")),
//           ),
//         );
//       },
//     );

//     String resp = await storeData().saveFavoriteVoiceNodes(
//       nodes: node,
//       isFavorite: isFavorite, // Pass the isFavorite status
//     );

//     Navigator.pop(context); // Close the saving dialog

//     if (resp == "Success") {
//       // Optionally show a success message or perform any other action upon successful save
//       print("Node saved successfully!");
//     } else {
//       // Handle error case
//       print("Error occurred while saving node: $resp");
//     }
//   } catch (e) {
//     print("Error occurred: $e");
//     // Handle error case
//   }
// }

// void deleteVoiceNode(Timestamp timestamp) async {
//   try {
//     QuerySnapshot querySnapshot = await FirebaseFirestore.instance
//         .collection('UsersVoiceNodes')
//         .where('timestamp', isEqualTo: timestamp)
//         .get();

//     querySnapshot.docs.forEach((doc) async {
//       await doc.reference.delete();
//     });

//     print('Node(s) deleted successfully!');
//   } catch (e) {
//     print('Error deleting node: $e');
//   }
// }

//     return Expanded(
//       child: Padding(
//         padding: EdgeInsets.only(bottom:10),
//         child: StreamBuilder(
//           stream: FirebaseFirestore.instance
//     .collection('UsersVoiceNodes')
//     .where('userEmail', isEqualTo: userEmail)

//     .snapshots(),
//           builder: (BuildContext context,
//               AsyncSnapshot<QuerySnapshot> snapshot) {
//             if (snapshot.hasError) {
//                print("Error: ${snapshot.error}");
//               return _buildErrorMessage("Something went wrong");
//             }
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return Center(
//                 child: CircularProgressIndicator(),
//               );
//             }
//             if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
//               return _buildErrorMessage("No data found");
//             }
//             return ListView.builder(
//               itemCount: snapshot.data!.docs.length,
//               itemBuilder: (BuildContext context, int index) {
//                 DocumentSnapshot nodes = snapshot.data!.docs[index];
//                 Map<String, dynamic> nodeData =
//                     nodes.data() as Map<String, dynamic>;
//               String    node = nodeData['nodes'] ?? '';

//                 // print("$node");

//                 return GestureDetector(
//                   onTap: () {
//                     // Handle post click
//                   },
//                   child: Card(

//                     elevation: 0.5,
//                     child: Container(
//                       height: 85,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(12),
//                         color: const Color(0xffF2F2F2),
//                       ),
//                       width: double.infinity,
//                       child: Padding(
//                         padding: const EdgeInsets.only(
//                             left: 10.0, right: 10.0, top: 10),
//                         child: SingleChildScrollView(
//                           scrollDirection: Axis.vertical,
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 node,
//                                 style: Theme.of(context)
//                                     .textTheme
//                                     .bodyLarge!
//                                     .copyWith(fontSize: 15),
//                               ),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 children: [
//                                   IconButton(
//                                     onPressed: () {
//                                       saveFavoriteVoiceNode(node);
//                                     },
//                                     icon: Icon(Icons.favorite_border_rounded),
//                                   ),
//                                   IconButton(
//                                     onPressed: () {
//                                         _speak(node);
//                                     },
//                                     icon: Icon(Icons.speaker),
//                                   ),
//                                   IconButton(
//                                     onPressed: () {
//                                        deleteVoiceNode(nodeData['timestamp']);
//                                     },
//                                     icon: Icon(Icons.delete),
//                                   ),
//                                 ],
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildErrorMessage(String message) {
//     return Center(
//       child: Text(
//         message,
//         style: TextStyle(fontSize: 18.0),
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:GestuSpeak/helper/resources.dart';

class ShowPost extends StatefulWidget {
  final String userEmail;

  ShowPost({Key? key, required this.userEmail}) : super(key: key);

  @override
  State<ShowPost> createState() => _ShowPostState();
}

class _ShowPostState extends State<ShowPost> {
  final FlutterTts flutterTts = FlutterTts();

  Future<void> _speak(String text) async {
    await flutterTts.setVolume(1.0);
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setPitch(1.0);
    await flutterTts.setLanguage("en-US");
    await flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    void saveFavoriteVoiceNode(
        String node, bool isFavorite, String docId) async {
      try {
        // showDialog(
        //   context: context,
        //   builder: (context) {
        //     return const Center(
        //       child: AlertDialog(
        //         actions: [Center(child: CircularProgressIndicator())],
        //         title: Center(child: Text("Saving..")),
        //       ),
        //     );
        //   },
        // );

        // String resp = await storeData().saveFavoriteVoiceNodes(
        //   nodes: node,
        //   isFavorite: isFavorite,
        // );
        String resp1 = await storeData().updateSaveVoiceNodes(
          docId,
          isFavorite,
        );

        // Navigator.pop(context); // Close the saving dialog

        if (resp1 == "Success") {
          // // Fetch the updated isFavorite value from Firestore
          // QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          //     .collection('UsersFavoriteVoiceNodes')
          //     .where('nodes', isEqualTo: node)
          //     .limit(1)
          //     .get();

          // if (querySnapshot.docs.isNotEmpty) {
          //   DocumentSnapshot snapshot = querySnapshot.docs.first;
          //   isFavorite = snapshot['isFavorite'] ?? false;
          //   print("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&$isFavorite");
          // }

          // // Update the UI to reflect the new isFavorite value
          // setState(() {
          //   isFavorite=isFavorite;
          // });
        } else {
          // Handle error case
          print("Error occurred while saving node: $resp1");
        }
      } catch (e) {
        print("Error occurred: $e");
        // Handle error case
      }
    }

    void deleteVoiceNode(Timestamp timestamp) async {
      try {
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('UsersVoiceNodes')
            .where('timestamp', isEqualTo: timestamp)
            .get();

        showDialog(
  context: context,
  builder: (context) {
    return Center(
      child: Container(
        width: 400, // Adjust the width as needed
        // height: 500, // Adjust the height as needed
        child: AlertDialog(
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text("Do you want to delete this message?",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),),
              ),
              SizedBox(height: 20), // Add spacing between text and buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("No"),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.black,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      querySnapshot.docs.forEach((doc) async {
                        await doc.reference.delete();
                      });
                      Navigator.pop(context);
                      print('Node(s) deleted successfully!');
                    },
                    child: Text("Yes"),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.red,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  },
);

      } catch (e) {
        print('Error deleting node: $e');
      }
    }

    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('UsersVoiceNodes')
              .where('userEmail', isEqualTo: widget.userEmail)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              print("Error: ${snapshot.error}");
              return _buildErrorMessage("Something went wrong");
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
              return _buildErrorMessage("No data found");
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                DocumentSnapshot nodes = snapshot.data!.docs[index];
                Map<String, dynamic> nodeData =
                    nodes.data() as Map<String, dynamic>;
                String node = nodeData['nodes'] ?? '';
                String docId = nodeData['key'] ?? '';
                bool isFavorite = nodeData['isFavorite'] ?? false;
                // print(
                // "=====================================================================$docId");

                return GestureDetector(
                  onTap: () {
                    // Handle post click
                  },
                  child: Card(
                    elevation: 0.5,
                    child: Container(
                      height: 85,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 10.0, right: 10.0, top: 10),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                node,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(fontSize: 15),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      saveFavoriteVoiceNode(
                                          node, !isFavorite, docId);
                                      // Toggle isFavorite
                                    },
                                    icon: Icon(
                                      isFavorite
                                          ? Icons.favorite
                                          : Icons.favorite_border_rounded,
                                      color: isFavorite
                                          ? Colors.red
                                          :null, // Update color based on isFavorite
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      _speak(node);
                                    },
                                    icon: Icon(Icons.speaker),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      deleteVoiceNode(nodeData['timestamp']);
                                    },
                                    icon: Icon(Icons.delete),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildErrorMessage(String message) {
    return Center(
      child: Text(
        message,
        style: TextStyle(fontSize: 18.0),
      ),
    );
  }
}
