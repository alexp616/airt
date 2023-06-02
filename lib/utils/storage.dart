import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:airt/utils/image.dart';
import 'dart:convert';
import 'dart:collection';

class Storage {
  static final firestore = FirebaseFirestore.instance;
  static final auth = FirebaseAuth.instance;
  List<ImageData> images;
  List<ImageData> styles;

  Storage(this.images, this.styles);

  static Future<Storage> initializeStorage() async {
    return Storage(await getImages(), await getStyles());
  }

  Future<void> update() async {
    images = await getImages();
    styles = await getStyles();
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

    return images.reversed.toList();
  }

  static Future<List<ImageData>> getStyles() async {
    List<ImageData> images = [];

    if (auth.currentUser?.uid != null) {
      final snapshot = await firestore.collection('users').doc(auth.currentUser?.uid).get();
      
      if (snapshot.exists) {
        for (String base64 in (snapshot.data() as LinkedHashMap<String, dynamic>)['savedStyles']) {
          images.add(ImageData(base64Decode(base64)));
        }
      }
    }

    return images.reversed.toList();
  }

  static Future<void> addImage(ImageData image) async {
    try {
      if (auth.currentUser?.uid != null) {
        await firestore.collection('users').doc(auth.currentUser?.uid).update({
          'generatedImages': FieldValue.arrayUnion([
            base64Encode(image.bytes)
          ])
        });
      }
    } catch (e) {}
  }

  static Future<void> addStyle(ImageData image) async {
    try {
      if (auth.currentUser?.uid != null) {
        await firestore.collection('users').doc(auth.currentUser?.uid).update({
          'savedStyles': FieldValue.arrayUnion([
            base64Encode(image.bytes)
          ])
        });
      }
    } catch (e) {}
  }
}