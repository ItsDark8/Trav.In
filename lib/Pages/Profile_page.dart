import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trav_in/Admin%20side/user_info_page.dart';
import 'package:trav_in/Pages/TIcket%20Booking/tab_pages/users_personal_info.dart';
import 'package:trav_in/Pages/Wallet_page.dart';
import 'package:trav_in/main_page.dart';

import '../Admin side/API Data/api_service.dart';

class profile_page extends StatefulWidget {
  const profile_page({super.key});

  @override
  State<profile_page> createState() => _profile_pageState();
}

class _profile_pageState extends State<profile_page> {
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    CurrentUserData();
  }

  Future<void> CurrentUserData() async {

    try{
      User? currentUser = FirebaseAuth.instance.currentUser;

      if(currentUser != null){
        String uid = currentUser.uid;
        DocumentSnapshot<Map<String, dynamic>> userDoc = await FirebaseFirestore.instance
            .collection('Users')
            .doc(uid)
            .get();

        if (userDoc.exists) {
          setState(() {
            userData = userDoc.data();
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
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile',style: TextStyle(fontWeight: FontWeight.bold),),
        leading: IconButton(icon: ImageIcon(AssetImage('Assets/Icons/menu.png'),
          color: Colors.blue,),
          onPressed: (){},),
        backgroundColor: Colors.transparent,
      ),
      body: userData == null
          ? Center(child: CircularProgressIndicator()):
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: SizedBox(
                height: 100,
                width: 100,
                child: CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: ImageIcon(AssetImage('Assets/flaticons/user.png'),size: 50,),
                ),
              )
            ),
          ),
          Text('Hi,${userData?['u_firstname'] ?? 'N/A'}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
             decoration:  BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(16),topRight: Radius.circular(16))
              ),
            ),
          ),
          
          //menu and setting option for user
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 300,
              decoration: BoxDecoration(
                //color: Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(16)),
                border: Border.all(color: Colors.black)
              ),
              child: SizedBox(
                height: 280,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //Personal info
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          child: Container(
                            width: width / 2.4,
                            height: 120,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(child: Image.asset('Assets/Icons/profile-icon/personal-profile.png'),
                                height: 50,
                                width: 50,),
                                Text('Personal Info'),
                              ],
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(16)),
                              color: Colors.blue
                            ),
                          ),
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>users_personal_info_page()));
                          },
                        ),

                        //Wallet
                        GestureDetector(
                          child: Container(
                            width: width / 2.4,
                            height: 120,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(child: Image.asset('Assets/Icons/profile-icon/purse.png'),
                                  height: 50,
                                  width: 50,),
                                  Text('wallet'),
                                ],
                              )
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(16)),
                                color: Colors.grey
                            ),
                          ),
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>wallet_page()));
                          },
                        ),
                      ],
                    ),

                    //Setting
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          child: Container(
                            width: width / 2.4,
                            height: 120,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(child: Image.asset('Assets/Icons/profile-icon/gear.png'),
                                height: 50,
                                width: 50,),
                                Text('Setting'),
                              ],
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(16)),
                                color: Colors.grey
                            ),
                          ),
                          onTap: (){}
                        ),

                        //LogOut
                        GestureDetector(
                          child: Container(
                            width: width / 2.4,
                            height: 120,
                            child:  Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(child: Image.asset('Assets/Icons/profile-icon/logout.png'),
                                height: 50,
                                width: 50,),
                                Text('Logout'),
                              ],
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(16)),
                                color: Colors.red
                            ),
                          ),
                          onTap: (){FirebaseAuth.instance.signOut();
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>main_page()));
                            },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
