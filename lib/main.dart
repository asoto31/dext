import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:dext/error.dart';
import 'package:dext/splash.dart';
import 'package:dext/home.dart';
import 'package:dext/login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          // Check for errors
          if (snapshot.hasError) {
            return Error();
          }
          // Once complete, show your application
          if (snapshot.connectionState == ConnectionState.done) {
            return FirebaseAuth.instance.currentUser != null
              ? Home()
              : LoginPage();
          }
          // Otherwise, show something whilst waiting for initialization to complete
          return Splash();
        }
      )
    );
  }
}
