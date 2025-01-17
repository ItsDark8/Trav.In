import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../Widgets/BottomNavigation.dart';

class users_personal_info_page extends StatefulWidget {
  const users_personal_info_page({super.key});

  @override
  State<users_personal_info_page> createState() => _users_personal_info_pageState();
}

final TextEditingController _email = TextEditingController();
final TextEditingController _pwd = TextEditingController();
final TextEditingController _phone = TextEditingController();
final TextEditingController _lastname = TextEditingController();
final TextEditingController _firstname = TextEditingController();

Future<DocumentSnapshot<Map<String, dynamic>>> dataInfo = FirebaseFirestore.instance.collection('Users').doc('u_id').get();

class _users_personal_info_pageState extends State<users_personal_info_page> {


  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    CurrentUserData();
  }

  Future<void> CurrentUserData() async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser != null) {
        String uid = currentUser.uid;
        DocumentSnapshot<Map<String, dynamic>> userDoc = await FirebaseFirestore.instance
            .collection('Users')
            .doc(uid)
            .get();

        if (userDoc.exists) {
          setState(() {
            userData = userDoc.data(); // Store the user's data in the userData variable

            // Set the initial values to the text fields
            _firstname.text = userData?['u_firstname'] ?? '';
            _lastname.text = userData?['u_lastname'] ?? '';
            _email.text = userData?['u_email'] ?? '';
            _pwd.text = userData?['u_password'] ?? '';
            _phone.text = userData?['u_phone'] ?? '';
          });
        } else {
          print('No user data found for this UID.');
        }
      } else {
        print('No user is currently logged in.');
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  Future<void> updateUserData() async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser != null) {
        String uid = currentUser.uid;

        // Update user document in Firestore
        await FirebaseFirestore.instance.collection('Users').doc(uid).update({
          'u_firstname': _firstname.text,
          'u_lastname': _lastname.text,
          'u_email': _email.text,
          'u_password': _pwd.text,
          'u_phone': _phone.text,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('User data updated successfully')),
        );
      } else {
        print('No user is currently logged in.');
      }
    } catch (e) {
      print('Error updating user data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating user data: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(appBar: AppBar(title: Text('Account Information'),),
    body: userData == null
      ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
            child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: TextField(
                    controller: _firstname,
                    decoration: InputDecoration(
                        label: Text('Firstname',),
                        fillColor: Colors.blueAccent.withAlpha(50),
                        filled: true,
                        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15)))
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: TextField(
                    controller: _lastname,
                    decoration: InputDecoration(
                        label: Text('Lastname',),
                        fillColor: Colors.blueAccent.withAlpha(50),
                        filled: true,
                        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15)))
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: TextField(
                    controller: _email,
                    decoration: InputDecoration(
                        label: Text('Email',),
                        fillColor: Colors.blueAccent.withAlpha(50),
                        filled: true,
                        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15)))
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: TextField(
                    controller: _pwd,
                    decoration: InputDecoration(
                        label: Text('Password',),
                        fillColor: Colors.blueAccent.withAlpha(50),
                        filled: true,
                        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15)))
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: TextField(
                    controller: _phone,
                    decoration: InputDecoration(
                        label: Text('Phone',),
                        fillColor: Colors.blueAccent.withAlpha(50),
                        filled: true,
                        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15)))
                    ),
                  ),
                ),
              ),
            
              Row(
                children: [Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(child: Container(
                    child: Center(child: Text('Update',style: TextStyle(fontSize: 15),)),
                    height: 62,
                    width: width/2.2,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.blueAccent
                    ),
                  ),
                    onTap: (){
                        updateUserData();
                    },),
                ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(child: Container(
                      child: Center(child: Text('Cancel',style: TextStyle(fontSize: 15),)),
                      height: 62,
                      width: width/2.2,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.blueAccent
                      ),
                    ),
                      onTap: (){
                        Navigator.push(context,MaterialPageRoute(builder: (context)=>bottomnavigation()));
                      },),
                  ),],
              )
                    ],
                ),
          ),);
  }
}
