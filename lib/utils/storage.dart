import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:airt/utils/image.dart';
import 'dart:convert';
import 'dart:collection';

class Storage {
  static final firestore = FirebaseFirestore.instance;
  static final auth = FirebaseAuth.instance;
  List<ImageData> images;

  Storage(this.images);

  static Future<Storage> initializeStorage() async {
    return Storage(await getImages());
  }

  Future<void> updateImages() async {
    images = await getImages();
  }

  static Future<List<ImageData>> getImages() async {
    List<ImageData> images = [];

    if (auth.currentUser?.uid != null) {
      final snapshot = await firestore.collection('users').doc(auth.currentUser?.uid).get();
      
      if (snapshot.exists) {
        for (String base64 in (snapshot.data() as LinkedHashMap<String, dynamic>)['generatedImages']) {
          images.add(ImageData(base64Decode(base64)));
        }
      }
    }

    return images;
  }

  static Future<void> addImage(ImageData image) async {
    if (auth.currentUser?.uid != null) {
      await firestore.collection('users').doc(auth.currentUser?.uid).update({
        'generatedImages': FieldValue.arrayUnion([
          base64Encode(image.bytes)
        ])
      });
    }
  }
}