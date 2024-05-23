import 'package:GestuSpeak/themes/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:GestuSpeak/components/my_drawer.dart';
import 'package:GestuSpeak/helper/alphabet_images.dart';
import 'package:provider/provider.dart';

class UserGuidePage extends StatefulWidget {
  const UserGuidePage({super.key});

  @override
  State<UserGuidePage> createState() => _UserGuidePageState();
}

class _UserGuidePageState extends State<UserGuidePage> {
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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Text("User Guide"),
            actions: [
              Row(
                children: [
                  Text("Dark Mode"),
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: CupertinoSwitch(
                        value:
                            Provider.of<ThemeProvider>(context, listen: false)
                                .isDarkMode,
                        onChanged: (value) {
                          Provider.of<ThemeProvider>(context, listen: false)
                              .toggleTheme();
                        }),
                  ),
                ],
              ),
            ],
            bottom: TabBar(tabs: [
              Tab(
                text: "Letters",
              ),
              Tab(
                text: "Strings",
              ),
            ]),
            backgroundColor: Theme.of(context).colorScheme.background,
            elevation: 0,
          ),
          // drawer: MyDrawer(),
          body: TabBarView(
            children: [
              ListView.builder(
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    margin: EdgeInsets.all(15),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Container(
                                height: 250,
                                padding: EdgeInsets.only(left: 15.0),
                                child: Image.asset(alphabetSymbols[index]))),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                            flex: 1,
                            child: Card(
                                elevation: 0.1,
                                color: Theme.of(context).colorScheme.secondary,
                                child: Container(
                                    height: 250,
                                    padding: EdgeInsets.all(20),
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                aslDescriptions[index],
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(fontSize: 17),
                                              )),
                                          Align(
                                              alignment: Alignment.bottomRight,
                                              child: IconButton(
                                                  onPressed: () {
                                                    _speak(
                                                        aslDescriptions[index]);
                                                  },
                                                  icon: Icon(Icons.speaker)))
                                        ],
                                      ),
                                    ))))
                      ],
                    ),
                  );
                },
                itemCount: alphabetSymbols.length,
              ),
              ListView.builder(
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    margin: EdgeInsets.all(15),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Container(
                                height: 250,
                                padding: EdgeInsets.only(left: 15.0),
                                child: Image.asset(stringSymbols[index]))),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                            flex: 1,
                            child: Card(
                                elevation: 0.1,
                                color: Theme.of(context).colorScheme.secondary,
                                child: Container(
                                    height: 250,
                                    padding: EdgeInsets.all(20),
                          
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                stringSymbolsDescription[index],
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(fontSize: 17),
                                              )),
                                          Align(
                                              alignment: Alignment.bottomRight,
                                              child: IconButton(
                                                  onPressed: () {
                                                    _speak(
                                                        stringSymbolsDescription[
                                                            index]);
                                                  },
                                                  icon: Icon(Icons.speaker)))
                                        ],
                                      ),
                                    )))
                      ],
                    ),
                  );
                },
                itemCount: stringSymbols.length,
              ),
            ],
          )),
    );
  }
}
