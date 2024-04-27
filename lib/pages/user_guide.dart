import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:gestuspeak/components/my_drawer.dart';
import 'package:gestuspeak/helper/alphabet_images.dart';

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
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text("User Guide"),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Image.asset(
                'assets/images/toggle.png',
                width: 30,
              ),
            ),
          ],
          backgroundColor: Colors.white,
          elevation: 0.5,
        ),
        drawer: MyDrawer(),
        body: ListView.builder(
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.all(5),
              child: Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Container(
                          height: 250,
                          child: Image.asset(alphabetSymbols[index]))),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                      flex: 1,
                      child: Card(
                          elevation: 0.1,
                          color: Color(0xffF2F2F2),
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
                                              _speak(aslDescriptions[index]);
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
        ));
  }
}
