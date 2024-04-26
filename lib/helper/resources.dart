import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

final FirebaseStorage _storage = FirebaseStorage.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final databaseReference = FirebaseDatabase.instance.ref();
final user = FirebaseAuth.instance.currentUser!;

class storeData {
  Future<String> uploadImageToStorage(String childName, Uint8List file) async {
    Reference ref = _storage.ref().child(childName);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String> saveData(
      {required String name,
      required String username,
      required String about,
      required String live,
      required Uint8List file}) async {
    String resp = "Some Error Occured";
    try {
      if (name.isNotEmpty || about.isNotEmpty) {
        final id1 = Timestamp.now();
        String imageUrl =
            await uploadImageToStorage('${id1}+profileImage', file);

        await _firestore.collection('Users').doc(user.email!).set({
          'name': name,
          'username': username,
          'about': about,
          'live': live,
          'imageLink': imageUrl,
          'userEmail': user.email,
        });
        resp = "Success";
      }
    } catch (e) {
      resp = e.toString();
    }
    return resp;
  }

  // Future<String> saveVoiceNodes({
  //   required String nodes,
  //   // bool isFavorite=false,
  // }) async {
  //   String resp = "Some Error Occured";
  //   try {
  //     if (nodes.isNotEmpty || nodes.isNotEmpty) {
  //       DocumentReference docRef =
  //           await _firestore.collection('UsersVoiceNodes').add({
  //         'nodes': nodes,
  //         'userEmail': user.email!,
  //         'timestamp': Timestamp.now(),
  //         'isFavorite':false
  //       });
  //       String key = docRef.id;

  //       // Update the document with the auto-generated key
  //       await docRef.update({'key': key});

  //       // await docRef.update({'isFavorite':isFavorite});
  //        resp = "Success";
  //     }
  //   } catch (e) {
  //     resp = e.toString();
  //   }
  //   return resp;
  // }

Future<String> saveVoiceNodes({
  required String nodes,
}) async {
  String resp = "Some Error Occurred";
  try {
    if (nodes.isNotEmpty) {
      List<String> substrings = generateSubstrings(nodes); // Generate substrings
      DocumentReference docRef =
          await _firestore.collection('UsersVoiceNodes').add({
        'nodes': nodes,
        'nodes_substrings': substrings, // Store substrings
        'userEmail': user.email!,
        'timestamp': Timestamp.now(),
        'isFavorite': false
      });
      String key = docRef.id;

      // Update the document with the auto-generated key
      await docRef.update({'key': key});

      resp = "Success";
    }
  } catch (e) {
    resp = e.toString();
  }
  return resp;
}

// Function to generate substrings
List<String> generateSubstrings(String text) {
  List<String> substrings = [];
  for (int i = 0; i < text.length; i++) {
    for (int j = i + 1; j <= text.length; j++) {
      substrings.add(text.substring(i, j));
    }
  }
  return substrings;
}

  Future<String> updateSaveVoiceNodes(String nodeId, bool isFavorite) async {

  String resp = "Some Error Occured";
  try {
    // print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@$isFavorite");
    // Get the reference to the document to be updated
    DocumentReference docRef =
        _firestore.collection('UsersVoiceNodes').doc(nodeId);

    // Update the isFavorite field of the document
    await docRef.update({'isFavorite': isFavorite});

    resp = "Success";
  } catch (e) {
    resp = e.toString();
  }
  return resp;
}


  Future<String> saveFavoriteVoiceNodes({
    required String nodes,
    required bool isFavorite,
  }) async {
    String resp = "Some Error Occurred";
    try {
      if (nodes.isNotEmpty) {
        // Check if the document already exists
        QuerySnapshot querySnapshot = await _firestore
            .collection('UsersFavoriteVoiceNodes')
            .where('nodes', isEqualTo: nodes)
            .where('userEmail', isEqualTo: user.email!)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          // Toggle the isFavorite value
          bool isFavorite = querySnapshot.docs.first.get('isFavorite');
          await querySnapshot.docs.first.reference.update({
            'isFavorite': !isFavorite,
            'timestamp': Timestamp.now(),
          });
        } else {
          // Create a new document
          await _firestore.collection('UsersFavoriteVoiceNodes').add({
            'nodes': nodes,
            'userEmail': user.email!,
            'isFavorite': true, // Set initial value to true
            'timestamp': Timestamp.now(),
          });
        }
        resp = "Success";
      }
    } catch (e) {
      resp = e.toString();
    }
    return resp;
  }
}
