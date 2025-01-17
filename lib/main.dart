import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:trav_in/Theme/Theme.dart';
import 'package:trav_in/firebase_options.dart';

import 'FireBase_database/auth_gate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Future.delayed(Duration(seconds: 1));
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trav.In',
      theme: lightMode,
      darkTheme: darkMode,
      debugShowCheckedModeBanner: false,
      home: AuthGate(),
    );
  }
}

