import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pixtasy/reposnsive/mobile_screen_layout.dart';
import 'package:pixtasy/reposnsive/responsive_layout_screen.dart';
import 'package:pixtasy/reposnsive/web_screen_layout.dart';
import 'package:pixtasy/screens/login_screen.dart';
import 'package:pixtasy/screens/signup_screen.dart';
import 'package:pixtasy/utils/colors.dart';

void main() async {
  //initialising flutter Widgets
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();-->error in web App
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyAlMlx0pyEcnrAQElMPcOa7rGucWjakTMs",
          appId: "1:646344959238:web:5cbfc2aaca391e330fea87",
          messagingSenderId: "646344959238",
          projectId: "pixtasy-998cb",
          storageBucket: "pixtasy-998cb.appspot.com"),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pixtasy',
      // I wanted to use a dark theme functions but some to be overridden....use .copyWith()
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: mobileBackgroundColor,
      ),
      // home: const ResponsiveLayout(
      //   mobileScreenLayout: MobileScreenLayout(),
      //   webScreenLayout: WebScreenLayout(),
      // ),
      // home: const LoginScreen(),
      // home: const SignUpScreen(),

      home: StreamBuilder(
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              return const ResponsiveLayout(
                mobileScreenLayout: MobileScreenLayout(),
                webScreenLayout: WebScreenLayout(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('${snapshot.error}'),
              );
            }
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: primaryColor),
            );
          }
          return const LoginScreen(); 
        },
        // stream: FirebaseAuth.instance.idTokenChanges(),
        // stream: FirebaseAuth.instance.userChanges(),
        stream: FirebaseAuth.instance.authStateChanges(),
        //this method only runs when user signin or signout
      ),
    );
  }
}
