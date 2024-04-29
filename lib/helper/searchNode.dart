import 'package:GestuSpeak/themes/theme_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:GestuSpeak/helper/resources.dart';
import 'package:provider/provider.dart';

class SearchNode extends StatefulWidget {
  const SearchNode({super.key});

  @override
  State<SearchNode> createState() => _SearchNodeState();
}

class _SearchNodeState extends State<SearchNode> {
  List searchResult = [];

void searchFromFirebase(String query) async {
  final result = await FirebaseFirestore.instance
      .collection('UsersVoiceNodes')
      .where('nodes_substrings', arrayContains: query)
      .get();

  setState(() {
    searchResult = result.docs.map((e) => e.data()).toList();
  });
}


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
    return Scaffold(
        appBar: AppBar(
        automaticallyImplyLeading: true,

        title: Text("Search Notes"),

        actions: [
          Row(
            children: [
              Text("Dark Mode"),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: CupertinoSwitch(
                    value: Provider.of<ThemeProvider>(context, listen: false)
                        .isDarkMode,
                    onChanged: (value) {
                      Provider.of<ThemeProvider>(context, listen: false)
                          .toggleTheme();
                    }),
              ),
            ],
          ),
        ],
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
        child: Column(
          children: [
            Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: TextField(
                  onChanged: (query) {
                    searchFromFirebase(query.toUpperCase());
                  },
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () {},
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    hintText: "Search Here",
                    labelText: "Search",
                  )),
            ),
            Expanded(
                child: ListView.builder(
              itemCount: searchResult.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                
                  onTap: () {
                    // Handle post click
                  },
                  child: Card(margin: EdgeInsets.only(top: 10),
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
                                searchResult[index]['nodes'],
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
                                      _speak(searchResult[index]['nodes']);
                                    },
                                    icon: Icon(Icons.speaker),
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
            )),
          ],
        ),
      ),
    );
  }
}
