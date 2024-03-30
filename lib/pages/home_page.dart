// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:gestuspeak/components/my_drawer.dart';
// import 'package:gestuspeak/helper/resources.dart';
// import 'package:gestuspeak/pages/favorite_page.dart';
// import 'package:gestuspeak/pages/more_notespage.dart';
// import 'package:gestuspeak/pages/note_page.dart';
// import 'package:flutter_tts/flutter_tts.dart';


// class HomePage extends StatelessWidget {

//   HomePage({super.key});


//   final FlutterTts flutterTts = FlutterTts();
//   Future<void> _speak(String text) async {
//   await flutterTts.setVolume(1.0);
//   await flutterTts.setSpeechRate(0.5);
//   await flutterTts.setPitch(1.0);
//   await flutterTts.setLanguage("en-US");
//   await flutterTts.speak(text);
// }

//   bool isSelect = true;
//   String nodes="This is my Laptop";



//   @override
//   Widget build(BuildContext context) {

//   //   String userName = "user";
//   // String? userImage =
//   //     "https://www.moroccoupclose.com/uwagreec/2018/12/default_avatar-2048x2048.png";
//   // final User? currentUser = FirebaseAuth.instance.currentUser!;

//   // Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetails() async {
//   //   return await FirebaseFirestore.instance
//   //       .collection('Users')
//   //       .doc(currentUser!.email)
//   //       .get();
//   // }
  
// void saveVoiceNode() async {
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
    
//     String resp = await storeData().saveVoiceNodes(nodes: nodes);
    
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


//     return Scaffold(
//       backgroundColor: Color(0xffF2F2F2),
//       appBar: AppBar(
//         actions: [

//            IconButton(onPressed: (){},icon: Icon(Icons.toggle_on,color: Color(0xffFFCB2D),)),
//            Padding(
//              padding: const EdgeInsets.only(right:10.0),
//              child: CircleAvatar(backgroundColor: Color(0xffF2F2F2),radius: 20,child: IconButton(onPressed: (){
//               FirebaseAuth.instance.signOut();
//              },icon: Icon(Icons.logout,color: Color(0xffFFCB2D),))),
//            ),
//         ],
//         backgroundColor: Colors.white,
//         elevation: 0,
//       ),
//       drawer: MyDrawer(),
//       body: 
//        Center(
//          child: Container(     
//            child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//              children: [
//                SingleChildScrollView(
//                 scrollDirection: Axis.vertical,
//                  child: Padding(
//                       padding: const EdgeInsets.all(20.0),
//                       child: Column(children: [
//                         Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(12),
//                             color: Colors.white,
//                           ),
//                           width: double.infinity,
//                           height: 300,
//                           child: Image.asset(
//                             'assets/images/hand.jpg',
//                             fit: BoxFit.contain,
//                             height: null,
//                             width: null,
//                             // height: 32,
//                           ),
//                         ),
//                         SizedBox(
//                           height: 15,
//                         ),
//                         Container(
//                           width: double.infinity,
//                            padding: const EdgeInsets.only(bottom:20),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(12),
//                             color: Colors.white,
//                           ),
                 
//                           child: Column(
//                             children: [
//                                Container(
//                                 decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),color: Color(0xffF2F2F2)),
//                                 width: double.infinity,
                              
//                                  margin: EdgeInsets.all(10),
//                                  height: 200,
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(15.0),
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Expanded(child: SingleChildScrollView(
//                                         scrollDirection: Axis.vertical,
//                                         child: Text(nodes??"You dont have text",style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 23),))),
//                                       Align(
//                                       alignment: Alignment.bottomRight,
//                                         child:  IconButton(
//                                           onPressed: () {
//                                               _speak(nodes);
//                                           },
//                                           icon: Icon(Icons.speaker),
//                                         ),)
//                                     ],
//                                   ),
//                                 ) ,
//                                ),
                              
                            
//                                   ElevatedButton(onPressed: (){
//                                      saveVoiceNode();
               
//                                   }, child:Text("Add note"),style: ElevatedButton.styleFrom(
//                                     foregroundColor: Color(0xffFFCB2D),backgroundColor: Color(0xff6B6A5D),
//                                   ),)
//                             ],
//                           ),
                          
//                         )
//                       ]),
//                     ),
//                ),
//              ],
//            ),
//          ),
//        ),
      
      
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

//         currentIndex: 1, // Set the initial index to Home
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



// // one time receive data ONLY
// import 'dart:async';
// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   BluetoothConnection? connection;
//   bool get isConnected => connection != null && connection!.isConnected;
//   String receivedData = "You don't have text";

//   @override
//   void initState() {
//     super.initState();
//     FlutterBluetoothSerial.instance
//         .openSettings()
//         .then((result) {
//           // print("Bluetooth status: $result");
//         });

//     FlutterBluetoothSerial.instance.onStateChanged().listen((state) {
//       if (state == BluetoothState.STATE_ON) {
//         _connect();
//       }
//     });
//   }

//   Future<void> _connect() async {
//     List<BluetoothDevice> devices = [];

//     // Fetch paired devices
//     devices = await FlutterBluetoothSerial.instance.getBondedDevices();

//     // Connect to HC-05 device
//     BluetoothDevice hc05 =
//         devices.firstWhere((device) => device.name == 'HC-05');

//     await BluetoothConnection.toAddress(hc05.address)
//         .then((_connection) {
//       print('Connected to: ${hc05.name}');
//       setState(() {
//         connection = _connection;
//         connection!.input!.listen(_onDataReceived).onDone(() {
//           if (isConnected) {
//             setState(() {
//               connection = null;
//             });
//           }
//         });
//       });
//     }).catchError((error) {
//       print('Cannot connect, exception occurred $error');
//     });
//   }

//   void _onDataReceived(Uint8List data) {
//     setState(() {
//       receivedData = String.fromCharCodes(data);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Bluetooth Communication'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               'Received Data:',
//             ),
//             Text(
//               receivedData,
//               style: TextStyle(fontSize: 24.0),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     connection?.dispose();
//   }
// }


import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  BluetoothConnection? connection;
  bool get isConnected => connection != null && connection!.isConnected;
  String receivedData = "You don't have text";

  @override
  void initState() {
    super.initState();
    _initBluetooth();
  }

  Future<void> _initBluetooth() async {
    if (await Permission.location.request().isGranted) {
      await _connectBluetooth();
    } else {
      // Location permission is not granted, handle accordingly
      // You may display a message or request permission again
    }
  }
Future<void> _connectBluetooth() async {
  List<BluetoothDevice> devices = [];
  devices = await FlutterBluetoothSerial.instance.getBondedDevices();
  BluetoothDevice? hc05;
  try {
    hc05 = devices.firstWhere((device) => device.name == 'HC-05');
  } catch (e) {
    print('HC-05 not found among bonded devices');
  }
  if (hc05 != null) {
    await _connectToDevice(hc05);
  } else {
    // HC-05 not paired, prompt user to pair through Bluetooth settings
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
      print('Cannot connect, exception occurred $error');
    });
  }

  void _onDataReceived(Uint8List data) {
    setState(() {
      receivedData = String.fromCharCodes(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bluetooth Communication'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Received Data:',
            ),
            Text(
              receivedData,
              style: TextStyle(fontSize: 24.0),
            ),
          ],
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





