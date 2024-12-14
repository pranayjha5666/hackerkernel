import 'package:flutter/material.dart';
import 'package:hackerkernel/Pages/Auth/Screen/login_screen.dart';
import 'package:hackerkernel/Pages/SplashScreen/splashScreen_page.dart';

void main() {
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen()
    );
  }
}


// A Code Written By Pranay Jha
// https://www.linkedin.com/in/pranay-jha-software/
