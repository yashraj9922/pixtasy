import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pixtasy/reposnsive/mobile_screen_layout.dart';
import 'package:pixtasy/reposnsive/responsive_layout_screen.dart';
import 'package:pixtasy/reposnsive/web_screen_layout.dart';
import 'package:pixtasy/utils/colors.dart';

void main() async {
  await Firebase.initializeApp();
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
      home: const ResponsiveLayout(
        mobileScreenLayout: MobileScreenLayout(),
        webScreenLayout: WebScreenLayout(),
      ),
    );
  }
}
