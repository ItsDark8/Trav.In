import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trav_in/Widgets/BottomNavigation.dart';
import 'package:trav_in/main_page.dart';

import '../Pages/Home_page.dart';
class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {

          // user is logged in
          if(snapshot.hasData) {
            return bottomnavigation();
          }

          // user is not logged in
          else {
            return const main_page();
          }
        },
      ),
    );
  }
}
