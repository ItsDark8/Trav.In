import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:trav_in/Widgets/TicketView.dart';

import 'Train_Ticket_Booking_page.dart';

class home_page extends StatefulWidget {
  const home_page({super.key});

  @override
  State<home_page> createState() => _home_pageState();
}

String UserName = 'Demo' ;
class _home_pageState extends State<home_page> {

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
            userData = userDoc.data(); // Store the user's data in the userData variable
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
    return Scaffold(
      appBar: AppBar(title: Text('Trav.In',style: TextStyle(fontWeight: FontWeight.bold),),
      leading: IconButton(icon: ImageIcon(AssetImage('Assets/Icons/menu.png'),
        color: Colors.blue,),
      onPressed: (){},),
        backgroundColor: Colors.transparent,
      ),

      backgroundColor: Theme.of(context).colorScheme.background,
      body:  userData == null
          ? Center(child: CircularProgressIndicator()):
      ListView(
        children: [
          Row(
            children: [
              SizedBox(width: 10,),
              Text('Hi,${userData?['u_firstname'] ?? 'N/A'}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
            ],
          ),
          Row(
            children: [
              SizedBox(width: 10,),
              Text('UpComing Travels',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
            ],
          ),
          Container(
          width: 400,
          height: 189,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TicketView(
                    Source_State: 'GJ',
                    Destination_State: 'GJ',
                    Source_City: 'Surat',
                    Destination_City: 'Goa',
                    Department_time: '05H:00M AM',
                    Seat_number: 24,
                    Ticket_Date: '1 MAY',
                    Train_Time: '04:45 AM')
            ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TicketView(
                    Source_State: 'GJ',
                    Destination_State: 'HP',
                    Source_City: 'Goa',
                    Destination_City: 'Shimal',
                    Department_time: '07H:55M PM',
                    Seat_number: 24,
                    Ticket_Date: '1 MAY',
                    Train_Time: '07:30 PM')
            ),
              Padding(
              padding: const EdgeInsets.all(8.0),
              child: TicketView(
                  Source_State: 'GJ',
                  Destination_State: 'UP',
                  Source_City: 'Surat',
                  Destination_City: 'Mumbie',
                  Department_time: '06H:45M PM',
                  Seat_number: 24,
                  Ticket_Date: '1 MAY',
                  Train_Time: '06:55 AM')
            ),],
          ),
        ),
        SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                child: Column(
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ImageIcon(AssetImage('Assets/Icons/ticket.png'),color: Colors.white,size: 35,),
                          ],
                        ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.red,)
                    ),
                    Text('Book\nTicket',textAlign: TextAlign.center,)
                  ],
                ),
                onTap: (){Navigator.push(context,MaterialPageRoute(builder: (context)=>ticket_booking_page()));
                }
              ),
            ),
            SizedBox(width: 5,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                      width: 70,
                      height: 70,
                      child: Icon(Icons.map,size: 30,color: Colors.white,),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.blue,)
                  ),
                  Text('Train\nSchedule',textAlign: TextAlign.center)
                ],
              ),
            ),
            SizedBox(width: 5,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                      width: 70,
                      height: 70,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ImageIcon(AssetImage('Assets/flaticons/search-file.png'),size: 31,color: Colors.white,),
                        ],
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.green,)
                  ),
                  Text('PNR\nEnquiry',textAlign: TextAlign.center)
                ],
              ),
            ),
            SizedBox(width: 5,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                child: Column(
                  children: [
                    Container(
                        width: 70,
                        height: 70,
                        child: Icon(Icons.account_circle_sharp,size: 40,color: Colors.white,),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.deepPurpleAccent,)
                    ),
                    Text('Track\nYour Train',textAlign: TextAlign.center)
                  ],
                ),
              ),
            )
          ],
        ),
          SizedBox(height: 10,),


          Row(
            children: [
              SizedBox(width: 10,),
              Text('Destinations',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
              SizedBox(width: 190,),
              Text('See More',style: TextStyle(color: Colors.blue),)
            ],
          ),
          Container(
            width: 400,
            height: 280,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 300,
                  height: 10,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.blue,
                  ),
                ),
              ),Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.blue,
                  ),
                ),
              ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]
      ),
    );
  }
}
