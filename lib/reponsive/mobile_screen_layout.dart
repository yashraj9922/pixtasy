import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  // String username = '';

  // @override
  // void initState() {
  //   super.initState();
  //   getUserName();
  // }

  // void getUserName() async {
  //   DocumentSnapshot snap = await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .get();
  //   // method to access data from firebase/firestore
  //   // print(snap.data());
  //   setState(() {
  //     username = (snap.data() as Map<String, dynamic>)['username'];
  //   });
  // }
// Use State Management to get the username....we will use provider package


  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        // child: Text('$username'),
        child: Text('username'),
      ),
    );
  }
}
