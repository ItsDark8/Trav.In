import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trav_in/Widgets/TicketWidget.dart';

class history_page extends StatefulWidget {
  const history_page({super.key});

  @override
  State<history_page> createState() => _history_pageState();
}

class _history_pageState extends State<history_page> {
  String? u_id;

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
            u_id = userData?['u_id'] ?? '';
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

  Future<void> deleteTicket(String ticketId) async {
    try {
      await FirebaseFirestore.instance.collection('Ticket_details').doc(ticketId).delete();
      print('Ticket deleted successfully');
    } catch (e) {
      print('Error deleting ticket: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: Text('History',style: TextStyle(fontWeight: FontWeight.bold),),
        leading: IconButton(icon: ImageIcon(AssetImage('Assets/Icons/menu.png'),
          color: Colors.blue,),
          onPressed: (){},),
        backgroundColor: Colors.transparent,
      ),
      body:  StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Ticket_details').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> dataInfo) {
          if (dataInfo.connectionState == ConnectionState.active) {
            if (dataInfo.hasData && u_id != null) {
              final filteredDocs = dataInfo.data!.docs.where((doc) => doc['u_id'] == u_id).toList();

              if (filteredDocs.isNotEmpty) {
                return ListView.builder(
                  itemCount: filteredDocs.length,
                  itemBuilder: (context, index) {
                    final ticketData = filteredDocs[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Ticketwidget(
                            source: ticketData['source'].toString(),
                            destination: ticketData['destination'].toString(),
                            Train_class: ticketData['class'].toString(),
                            type: ticketData['type'].toString(),
                            date: ticketData['date'].toString(),
                            train_time: ticketData['train_time'].toString(),
                            seat: ticketData['no_of_seats'].toString(),
                            email: ticketData['u_email'].toString(),
                            price: ticketData['price'].toString(),
                            ticketId: ticketData.id,
                            onTap: (){deleteTicket(ticketData.id);},
                          ),
                        ],
                      ),
                    );
                  },
                );
              } else {
                return Center(child: Text('NO TICKETS'));
              }
            } else if (dataInfo.hasError) {
              return Center(child: Text("Error: ${dataInfo.error.toString()}"));
            } else {
              return Center(child: Text('No Data Found!'));
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
