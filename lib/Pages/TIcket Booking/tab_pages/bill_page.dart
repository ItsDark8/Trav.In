import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trav_in/Pages/Train_Ticket_Booking_page.dart';
import 'package:trav_in/Widgets/BottomNavigation.dart';

class bill_page extends StatefulWidget {
  final price;
  final date;
  final String train_time;
  final String seat;
  final String train_class;
  final String type;
  final String fromStation;
  final String toStation;
  const bill_page({super.key,required this.fromStation,required this.toStation,required this.price,required this.date,required this.seat,required this.train_time,required this.train_class,required this.type});

  @override
  State<bill_page> createState() => _bill_pageState();
}
class _bill_pageState extends State<bill_page> {
  Map<String, dynamic>? userData;
  int? totalPrice;

  @override
  void initState() {
    super.initState();
    CurrentUserData();
    _calculateTotalPrice();
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
  Future<void> addUser(String source,String destination, String trian_class,String type,String date,String no_of_seats,String email,String u_id,int price,String train_time) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      await firestore.collection('Ticket_details').add({
        'source': source,
        'destination': destination,
        'class': trian_class,
        'type' : type,
        'date' : date,
        'no_of_seats' : no_of_seats,
        'u_email' : email,
        'u_id' : u_id,
        'train_time' : train_time,
        'price' : totalPrice
      });

      print("User Added Successfully");
      Navigator.push(context, MaterialPageRoute(builder: (context) => bottomnavigation()));
    } catch (e) {
      print("Failed to add user: $e");
    }
  }

  void _calculateTotalPrice() {
    setState(() {
      totalPrice = (widget.price is String ? int.parse(widget.price) : widget.price) *
          (widget.seat is String ? int.parse(widget.seat) : widget.seat);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bill Page', style: TextStyle(fontWeight: FontWeight.bold),),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => ticket_booking_page()));
          },
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(children: [Text('From : '),Text(widget.fromStation)],mainAxisAlignment: MainAxisAlignment.spaceBetween,),
                        Row(children: [Text('To : '),Text(widget.toStation)],mainAxisAlignment: MainAxisAlignment.spaceBetween),
                        Row(children: [Text('Date :'),Text(widget.date)],mainAxisAlignment: MainAxisAlignment.spaceBetween),
                        Row(children: [Text('Seats :'),Text(widget.seat)],mainAxisAlignment: MainAxisAlignment.spaceBetween),
                        Row(children: [Text('Train Time :'),Text(widget.train_time)],mainAxisAlignment: MainAxisAlignment.spaceBetween),
                        Row(children: [Text('Traveler Name :'),Row(
                          children: [
                            Text('${userData?['u_firstname'] ?? 'N/A'}'),
                            Text(' '),
                            Text('${userData?['u_lastname'] ?? 'N/A'}')
                          ],
                        )],mainAxisAlignment: MainAxisAlignment.spaceBetween),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(16))
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(children: [Text('Ticket Price :'),Text( widget.price.toString())],mainAxisAlignment: MainAxisAlignment.spaceBetween),
                        Row(children: [Text('Toll Fee :'),Text('0')],mainAxisAlignment: MainAxisAlignment.spaceBetween),
                        Row(children: [Text('Accident Insurance :'),Text('0')],mainAxisAlignment: MainAxisAlignment.spaceBetween),
                        Row(children: [Text('Offer :'),Text('0')],mainAxisAlignment: MainAxisAlignment.spaceBetween),
                        Row(children: [Text('Number of Seats :'),Text('X'+widget.seat)],mainAxisAlignment: MainAxisAlignment.spaceBetween),
                        Row(children: [Text('Total Price :'),Text('${totalPrice}')],mainAxisAlignment: MainAxisAlignment.spaceBetween),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(16))
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                child: Container(
                  alignment: Alignment.center,
                  height: 70,
                  child: Text('Process',style: TextStyle(fontSize: 16,color: Colors.white,)),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.blueAccent
                  ),
                ),
                onTap: (){
                  addUser(widget.fromStation,widget.toStation,widget.train_class,widget.type,widget.date,widget.seat,userData?['u_email'],userData?['u_id'],totalPrice!, widget.train_time);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
