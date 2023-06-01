import 'package:airt/utils/storage.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:airt/firebase_options.dart';
import 'package:airt/utils/auth.dart';

class Authentication {
  final FirebaseApp app;
  final Storage storage;
  FirebaseAuth get auth => FirebaseAuth.instance;
  
  const Authentication(this.app, this.storage);

  static Future<Authentication> initializeFirebase() async {
    return Authentication(
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform
      ),
      await Storage.initializeStorage()
    );
  }

  Future<User?> signInWithGoogle() async {
    UserCredential? credential;

    try {
      if (kIsWeb) {
        final provider = GoogleAuthProvider();
        credential = await auth.signInWithPopup(provider);
      } else {
        final signIn = GoogleSignIn();
        final account = await signIn.signIn();

        if (account != null) {
          final signInAuth = await account.authentication;
          final credentialAuth = GoogleAuthProvider.credential(
            accessToken: signInAuth.accessToken,
            idToken: signInAuth.idToken
          );

          credential = await auth.signInWithCredential(credentialAuth);
        }
      }
    } catch (e) {}

    DocumentSnapshot<Map<String, dynamic>> snapshot = 
      await FirebaseFirestore.instance.collection('users')
        .doc(credential!.user!.uid).get();
    
    if (!snapshot.exists) {
      await FirebaseFirestore.instance.collection('users')
        .doc(credential.user!.uid)
        .set({ 'generatedImages': [] });
    }

    return credential.user;
  }
}