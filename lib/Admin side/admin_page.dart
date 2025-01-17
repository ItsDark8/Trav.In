import 'package:flutter/material.dart';
import 'package:trav_in/Admin%20side/ticket_database_page.dart';
import 'package:trav_in/Admin%20side/train_database_page.dart';
import 'package:trav_in/Admin%20side/user_info_page.dart';
import 'package:trav_in/main_page.dart';

class admin_page extends StatefulWidget {
  const admin_page({super.key});

  @override
  State<admin_page> createState() => _admin_pageState();
}

class _admin_pageState extends State<admin_page> {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Side',style: TextStyle(fontWeight: FontWeight.bold),),
        leading: IconButton(icon: ImageIcon(AssetImage('Assets/Icons/menu.png'),
          color: Colors.blue,),
          onPressed: (){},),
        backgroundColor: Colors.transparent,
      ),
      body: Column(
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
          Text('Hello,Admin!',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
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
                    //User info
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
                                Text('User Info'),
                              ],
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(16)),
                                color: Colors.blue
                            ),
                          ),
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>user_info_page()));
                          },
                        ),

                        //Ticket Info
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
                                    Text('Ticket Info'),
                                  ],
                                )
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(16)),
                                color: Colors.grey
                            ),
                          ),
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>ticket_database_page()));
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
                                Text('Train Database'),
                              ],
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(16)),
                                color: Colors.grey
                            ),
                          ),
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>train_database_page()));
                          },
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
                          onTap: (){
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
