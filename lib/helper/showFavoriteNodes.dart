import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:gestuspeak/helper/resources.dart';

class ShowFavoriteNode extends StatelessWidget {
  final String userEmail;

  ShowFavoriteNode({Key? key, required this.userEmail}) : super(key: key);

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
              itemCount: snapshot.data!.docs.length * 2 -
                  1, // Double the count to account for possible placeholders
              itemBuilder: (BuildContext context, int index) {
                if (index.isOdd) {
                  // Odd indices represent non-favorite placeholders
                  return Container(); // Adjust the height as needed
                } else {
                  // Even indices represent actual favorite nodes
                  int favIndex =
                      index ~/ 2; // Calculate the index of favorite node
                  DocumentSnapshot nodes = snapshot.data!.docs[favIndex];
                  Map<String, dynamic> nodeData =
                      nodes.data() as Map<String, dynamic>;
                  bool isFavorite = nodeData['isFavorite'] ?? false;
                  String node = nodeData['nodes'] ?? '';
                  String docId = nodeData['key'] ?? '';

                  if (isFavorite) {
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
                            color: const Color(0xffF2F2F2),
                          ),
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 10.0,
                              right: 10.0,
                              top: 10,
                            ),
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
                                        onPressed: () async {
                                          // Handle favorite button tap
                                          String resp1 = await storeData()
                                              .updateSaveVoiceNodes(
                                            docId,
                                            false,
                                          );
                                        },
                                        icon: Icon(
                                          Icons.favorite,
                                          color: Colors.red,
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
                                          // Handle more options button tap
                                        },
                                        icon: Icon(Icons.more_vert_rounded),
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
                  } else {
                    // Placeholder for non-favorite nodes
                    return Container(); // Adjust the height as needed
                  }
                }
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
