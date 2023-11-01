import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:pixtasy/models/user.dart' as model;
import 'package:pixtasy/resources/storage_methods.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // signing up the user
  Future<String> signUpUser({
    required String email,
    required String password,
    required String bio,
    required String username,
    required Uint8List file, //need to store this file somewhere
  }) async {
    String res = 'Some error occured';
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          bio.isNotEmpty ||
          username.isNotEmpty ||
          file != null) {
        //register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        // print(cred.user!.uid);

        String photoUrl = await StorageMethods()
            .uploadImageToStorage('profilePics', file, false);

        //add user to database
        model.User user = model.User(
            username: username,
            uid: cred.user!.uid,
            photoUrl: photoUrl,
            email: email,
            bio: bio,
            followers: [],
            following: []);

        await _firestore
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.toJson());
        // {
        // 'username': username,
        // 'uid': cred.user!.uid,
        // 'email': email,
        // 'bio': bio,
        // 'followers': [],
        // 'following': [],
        // 'photoUrl': photoUrl,
        // }
        // );

        // await _firestore.collection('users').add({
        //   'username': username,
        //   'uid': cred.user!.uid,
        //   'email': email,
        //   'bio': bio,
        //   'followers': [],
        //   'following': [],
        // });

        res = "success";
      }
      // }
      // on FirebaseAuthException catch (err) {
      //   if (err.code == 'invalid-email') {
      //     res = 'The email is badly formatted,';
      //   } else if (err.code == 'weak-password') {
      //     res = 'Password should be at least 6 characters';
      //   }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

// logging in the user
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = 'Some error occurred';

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = 'success';
      } else {
        res = 'Please enter all the fields';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
