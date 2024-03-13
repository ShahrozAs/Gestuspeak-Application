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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class ShowOneNode extends StatelessWidget {
  final String userEmail;
  ShowOneNode({Key? key, required this.userEmail}) : super(key: key);

  
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
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('UsersVoiceNodes')
              .where('userEmail', isEqualTo: userEmail)
              .limit(1)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
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
                print("$node");

                return GestureDetector(
                  onTap: () {
                    // Handle post click
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        node,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(fontSize: 15),
                      ),
                      Align(
                          alignment: Alignment.bottomRight,
                          child: IconButton(
                            onPressed: () {
                               _speak(node);
                            },
                            icon: Icon(Icons.speaker),
                          )),
                    ],
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
