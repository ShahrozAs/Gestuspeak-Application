import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';
import 'package:GestuSpeak/auth/auth.dart';
import 'package:GestuSpeak/auth/login_or_register.dart';
import 'package:GestuSpeak/themes/theme_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:GestuSpeak/components/my_drawer.dart';
import 'package:GestuSpeak/helper/helper_functions.dart';
import 'package:GestuSpeak/helper/resources.dart';
import 'package:GestuSpeak/pages/favorite_page.dart';
import 'package:GestuSpeak/pages/note_page.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  BluetoothConnection? connection;
  bool get isConnected => connection != null && connection!.isConnected;
  String receivedData = "";
  String receivedDataString = "";

  final FlutterTts flutterTts = FlutterTts();
  Future<void> _speak(String text) async {
    await flutterTts.setVolume(1.0);
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setPitch(1.0);
    await flutterTts.setLanguage("en-US");
    await flutterTts.speak(text);
  }

  void saveVoiceNode() async {
    try {
      showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: AlertDialog(
              actions: [Center(child: CircularProgressIndicator())],
              title: Center(child: Text("Saving..")),
            ),
          );
        },
      );

      String resp = await storeData().saveVoiceNodes(nodes: receivedData);

      Navigator.pop(context); 

      if (resp == "Success") {
        displayMessageToUser("Node saved successfully", context);

        print("Node saved successfully!");
      } else {
   
        print("Error occurred while saving node: $resp");
      }
    } catch (e) {
      print("Error occurred: $e");
   
    }
  }
  void saveVoiceNodeString() async {
    try {
      showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: AlertDialog(
              actions: [Center(child: CircularProgressIndicator())],
              title: Center(child: Text("Saving..")),
            ),
          );
        },
      );

      String resp = await storeData().saveVoiceNodes(nodes: receivedDataString);

      Navigator.pop(context); 

      if (resp == "Success") {
        displayMessageToUser("Node saved successfully", context);

        print("Node saved successfully!");
      } else {
   
        print("Error occurred while saving node: $resp");
      }
    } catch (e) {
      print("Error occurred: $e");
   
    }
  }

  @override
  void initState() {
    super.initState();
    _initBluetooth();
  }

  Future<void> _initBluetooth() async {
    if (await Permission.location.request().isGranted) {
      await _connectBluetooth();
    } else {
     
    }
  }

  Future<void> _connectBluetooth() async {
    List<BluetoothDevice> devices = [];
    devices = await FlutterBluetoothSerial.instance.getBondedDevices();
    BluetoothDevice? hc05;
    try {
      hc05 = devices.firstWhere((device) => device.name == 'HC-05');
    } catch (e) {
      displayMessageToUser('HC-05 not found among bonded devices', context);
      print('HC-05 not found among bonded devices');
    }
    if (hc05 != null) {
      await _connectToDevice(hc05);
    } else {
      FlutterBluetoothSerial.instance.openSettings();
    }
  }

  Future<void> _connectToDevice(BluetoothDevice device) async {
    await BluetoothConnection.toAddress(device.address).then((conn) {
      print('Connected to: ${device.name}');
      setState(() {
        connection = conn;
        connection!.input!.listen(_onDataReceived).onDone(() {
          if (isConnected) {
            setState(() {
              connection = null;
            });
          }
        });
      });
    }).catchError((error) {
      displayMessageToUser(
          'Cannot connect, exception occurred $error', context);
      print('Cannot connect, exception occurred $error');
    });
  }



void _onDataReceived(Uint8List data) {
  String receivedString = String.fromCharCodes(data);
  
  if (receivedString.contains("HELLO") ||
      receivedString.contains("GOODBYE") ||
      receivedString.contains("THANK YOU") ||
      receivedString.contains("YES") ||
      receivedString.contains("NO") ||
      receivedString.contains("I WANT TO DRINK WATER") ||
      receivedString.contains("HOW ARE YOU?") ||
      receivedString.contains("I NEED YOUR HELP") ||
      receivedString.contains("I WANT TO GO TO THE BATHROOM") ||
      receivedString.contains("I AM HUNGRY") ||
      receivedString.contains("I AM THIRSTY") ||
      receivedString.contains("I AM SORRY") ||
      receivedString.contains("NICE TO MEET YOU") ||
      receivedString.contains("I AM FINE") ||
      receivedString.contains("I AM NOT FEELING WELL") ||
      receivedString.contains("WHAT IS YOUR NAME")) {
    setState(() {
    print("Condition met:=============================================================== $receivedString");
      receivedDataString += receivedString+"\n";
    });
  } else {
    setState(() {
    print("Else condition:============================================================== $receivedString");
      receivedString.length==1?receivedData += receivedString:'';
    });
  }
}


  @override
  Widget build(BuildContext context) {


    String imageAsset = '';
    String imageAssetString = '';

    if (receivedData.isNotEmpty) {
     
      String lastCharacter = receivedData.substring(receivedData.length - 1);

 
      if (RegExp(r'[A-Za-z]').hasMatch(lastCharacter)) {
   
        int index =
            lastCharacter.toUpperCase().codeUnitAt(0) - 'A'.codeUnitAt(0);
        if (index >= 0 && index < alphabetSymbols.length) {
          imageAsset = alphabetSymbols[index];
        } else {
  
          imageAsset =
              'assets/images/hand.jpg'; 
        }
      } else {
     
        imageAsset =
            'assets/images/hand.jpg'; 
      }
    }

    if (receivedDataString.isNotEmpty) {
      String lastCharacter =
          receivedDataString.substring(receivedDataString.length - 3);
    
      print("Last 2 characters================================================================================$lastCharacter");
      print("NUMBER OF characters================================================================================${lastCharacter.length}");
      if (lastCharacter=="LO\n") {
       imageAssetString=stringSymbols[0];
      } 
      else if(lastCharacter=="U?\n"){
       imageAssetString=stringSymbols[1];
      }
      else if(lastCharacter=="LP\n"){
       imageAssetString=stringSymbols[2];
      }
      else if(lastCharacter=="NE\n"){
       imageAssetString=stringSymbols[3];
      }
    
      else if(lastCharacter=="RY\n"){
       imageAssetString=stringSymbols[5];
      }
      else if(lastCharacter=="ER\n"){
       imageAssetString=stringSymbols[6];
      }
      else if(lastCharacter=="OM\n"){
       imageAssetString=stringSymbols[7];
      }
      else if(lastCharacter=="LL\n"){
       imageAssetString=stringSymbols[8];
      }
      else if(lastCharacter=="ME\n"){
       imageAssetString=stringSymbols[9];
      }
      else if(lastCharacter=="YE\n"){
       imageAssetString=stringSymbols[10];
      }
        else if(lastCharacter=="OU\n"){
       imageAssetString=stringSymbols[4];
      }
    
      else {
     
        imageAssetString =
            'assets/images/hand.jpg'; 
      }
    }

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        // backgroundColor: Color(0xffF2F2F2),
        appBar: AppBar(
          actions: [
            Row(
              children: [
                Text("Dark Mode"),
                CupertinoSwitch(
                    value: Provider.of<ThemeProvider>(context, listen: false)
                        .isDarkMode,
                    onChanged: (value) {
                      Provider.of<ThemeProvider>(context, listen: false)
                          .toggleTheme();
                    }),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Center(
                            child: Container(
                              width: 400, 
                              child: AlertDialog(
                                content: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(
                                        "Are you sure you want to logout?",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16),
                                      ),
                                    ),
                                    SizedBox(
                                        height:
                                            20), 
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
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
                                          onPressed: () async {
                                            await FirebaseAuth.instance
                                                .signOut();
                                            Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      AuthPage()),
                                              (route) =>
                                                  false, 
                                            );
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
                    },
                    child: Image.asset('assets/images/logout2.png', width: 40),
                  ),
                )
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
        drawer: MyDrawer(),
        body: TabBarView(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  if (!isConnected && receivedData.isEmpty)
                    Text(
                      'You don\'t have text',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                    ),
                  if (isConnected && receivedData.isNotEmpty)
                    Text(
                      'Received Data:',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  SizedBox(height: 10),
                  if (receivedData.isNotEmpty)
                    Center(
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: Color.fromRGBO(33, 32, 33, 1),
                                      ),
                                      width: double.infinity,
                                      height: 300,
                                      child: Image.asset(
                                        imageAsset,
                                        fit: BoxFit.contain,
                                        height: null,
                                        width: null,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Container(
                                      width: double.infinity,
                                      padding:
                                          const EdgeInsets.only(bottom: 20),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: Theme.of(context)
                                            .colorScheme
                                            .background,
                                      ),
                                      child: Column(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondary),
                                            width: double.infinity,
                                            margin: EdgeInsets.all(10),
                                            height: 200,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(15.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child:
                                                        SingleChildScrollView(
                                                      scrollDirection:
                                                          Axis.vertical,
                                                      child: Text(
                                                        receivedData ??
                                                            "You dont have text",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyLarge!
                                                            .copyWith(
                                                                fontSize: 23),
                                                      ),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.bottomRight,
                                                    child: IconButton(
                                                      onPressed: () {
                                                        _speak(receivedData);
                                                      },
                                                      icon: Icon(Icons.speaker),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              ElevatedButton(
                                                onPressed: () {
                                                  saveVoiceNode();
                                                  setState(() {
                                                    receivedData = "";
                                                  });
                                                },
                                                child: Text("Add note"),
                                                style: ElevatedButton.styleFrom(
                                                  foregroundColor:
                                                      Color(0xffFFCB2D),
                                                  backgroundColor:
                                                      Color(0xff6B6A5D),
                                                ),
                                              ),
                                              Container(
                                                width: 100, 
                                                height: 40,                                                 decoration: BoxDecoration(
                                                  color: Color(
                                                      0xff6B6A5D), 
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50), 
                                                ),
                                                child: IconButton(
                                                  onPressed: () {
                                                    if (receivedData
                                                        .isNotEmpty) {
                                                      setState(() {
                                                        receivedData =
                                                            receivedData.substring(
                                                                0,
                                                                receivedData
                                                                        .length -
                                                                    1);
                                                      });
                                                    }
                                                  },
                                                  icon: Icon(
                                                    Icons.backspace, size: 20,
                                                    color: Color(
                                                        0xffFFCB2D), 
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: 100, 
                                                height: 40,                                                 decoration: BoxDecoration(
                                                  color: Color(
                                                      0xff6B6A5D),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50), 
                                                ),
                                                child: IconButton(
                                                  onPressed: () {
                                                    if (receivedData
                                                        .isNotEmpty) {
                                                      setState(() {
                                                       
                                                        receivedData = "";
                                                      });
                                                    }
                                                  },
                                                  icon: Icon(
                                                    Icons.delete_forever,
                                                    size: 20,
                                                    color: Color(
                                                        0xffFFCB2D), // Set the icon color
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),

            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  if (!isConnected && receivedDataString.isEmpty)
                    Text(
                      'You don\'t have String',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                    ),
                  if (isConnected && receivedDataString.isNotEmpty)
                    Text(
                      'Received Data:',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  SizedBox(height: 10),
                  if (receivedDataString.isNotEmpty)
                    Center(
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: Color.fromRGBO(33, 32, 33, 1),
                                      ),
                                      width: double.infinity,
                                      height: 300,
                                      child: Image.asset(
                                        imageAssetString,
                                        fit: BoxFit.contain,
                                        height: null,
                                        width: null,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Container(
                                      width: double.infinity,
                                      padding:
                                          const EdgeInsets.only(bottom: 20),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: Theme.of(context)
                                            .colorScheme
                                            .background,
                                      ),
                                      child: Column(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondary),
                                            width: double.infinity,
                                            margin: EdgeInsets.all(10),
                                            height: 200,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(15.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child:
                                                        SingleChildScrollView(
                                                      scrollDirection:
                                                          Axis.vertical,
                                                      child: Text(
                                                        receivedDataString ??
                                                            "You dont have String",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyLarge!
                                                            .copyWith(
                                                                fontSize: 23),
                                                      ),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.bottomRight,
                                                    child: IconButton(
                                                      onPressed: () {
                                                        _speak(
                                                            receivedDataString);
                                                      },
                                                      icon: Icon(Icons.speaker),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              ElevatedButton(
                                                onPressed: () {
                                                  saveVoiceNodeString();
                                                  setState(() {
                                                    receivedDataString = "";
                                                  });
                                                },
                                                child: Text("Add note"),
                                                style: ElevatedButton.styleFrom(
                                                  foregroundColor:
                                                      Color(0xffFFCB2D),
                                                  backgroundColor:
                                                      Color(0xff6B6A5D),
                                                ),
                                              ),
                                              Container(
                                                width: 100, 
                                                height: 40, 
                                                decoration: BoxDecoration(
                                                  color: Color(
                                                      0xff6B6A5D), 
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50), 
                                                ),
                                                child: IconButton(
                                                  onPressed: () {
                                                    if (receivedDataString
                                                        .isNotEmpty) {
                                                      setState(() {
                                                        receivedDataString =
                                                            receivedDataString
                                                                .substring(
                                                                    0,
                                                                    receivedDataString
                                                                            .length -
                                                                        1);
                                                      });
                                                    }
                                                  },
                                                  icon: Icon(
                                                    Icons.backspace,
                                                    size: 20,
                                                    color: Color(
                                                        0xffFFCB2D), 
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: 100, 
                                                height: 40,                                                decoration: BoxDecoration(
                                                  color: Color(
                                                      0xff6B6A5D), 
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50),
                                                ),
                                                child: IconButton(
                                                  onPressed: () {
                                                    if (receivedDataString
                                                        .isNotEmpty) {
                                                      setState(() {
                                                        receivedDataString = "";
                                                      });
                                                    }
                                                  },
                                                  icon: Icon(
                                                    Icons.delete_forever,
                                                    size: 20,
                                                    color: Color(
                                                        0xffFFCB2D),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),

      
          ],
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
          currentIndex: 1, // Set the initial index to Home
          onTap: (index) {
            // Handle navigation on item tap
            switch (index) {
              case 0:
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NotePage(),
                  ),
                );
                break;
              case 1:
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                );
                break;
              case 2:
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FavoriteNotesPage(),
                  ),
                );
                break;
              case 3:
                break;
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    connection?.dispose();
  }
}

const alphabetSymbols = [
  'assets/images/A.png',
  'assets/images/B.png',
  'assets/images/C.png',
  'assets/images/D.png',
  'assets/images/E.png',
  'assets/images/F.png',
  'assets/images/G.png',
  'assets/images/H.png',
  'assets/images/I.png',
  'assets/images/J.png',
  'assets/images/K.png',
  'assets/images/L.png',
  'assets/images/M.png',
  'assets/images/N.png',
  'assets/images/O.png',
  'assets/images/P.png',
  'assets/images/Q.png',
  'assets/images/R.png',
  'assets/images/S.png',
  'assets/images/T.png',
  'assets/images/U.png',
  'assets/images/V.png',
  'assets/images/W.png',
  'assets/images/X.png',
  'assets/images/Y.png',
  'assets/images/Z.png'
];

const stringSymbols=[
  'assets/images/A.jpg',
  'assets/images/B.jpg',
  'assets/images/D.jpg',
  'assets/images/E.jpg',
  'assets/images/F.jpg',
  'assets/images/G.jpg',
  'assets/images/H.jpg',
  'assets/images/I.jpg',
  'assets/images/U.jpg',
  'assets/images/W.jpg',
  'assets/images/Y.jpg',
];