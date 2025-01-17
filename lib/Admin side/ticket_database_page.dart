import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trav_in/Widgets/Ticketview_admin.dart';

class ticket_database_page extends StatefulWidget {
  const ticket_database_page({super.key});

  @override
  State<ticket_database_page> createState() => _ticket_database_pageState();
}

class _ticket_database_pageState extends State<ticket_database_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ticket Database'),),
      body:  StreamBuilder(stream: FirebaseFirestore.instance.collection('Ticket_details').snapshots(),
          builder: (context,dataInfo){
            if(dataInfo.connectionState == ConnectionState.active){
              if(dataInfo.hasData){
                return ListView.builder(
                  itemBuilder: (context,index){
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          ticketView_admin(
                            source: dataInfo.data!.docs[index]['source'].toString(),
                            destination: dataInfo.data!.docs[index]['destination'].toString(),
                            Train_class: dataInfo.data!.docs[index]['class'].toString(),
                            type: dataInfo.data!.docs[index]['type'].toString(),
                            date: dataInfo.data!.docs[index]['date'].toString(),
                            train_time: dataInfo.data!.docs[index]['train_time'].toString(),
                            seat: dataInfo.data!.docs[index]['no_of_seats'].toString(),
                            email: dataInfo.data!.docs[index]['u_email'].toString(),
                            price: dataInfo.data!.docs[index]['price'].toString(),
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: dataInfo.data!.docs.length,);
              }
              else if(dataInfo.hasError){
                return Center(child: Text("${dataInfo.hasError.toString()}"),);
              }
              else{
                return Center(child: Text('No Data Found!'),);
              }
            }
            else{
              return Center(child: CircularProgressIndicator(),);
            }
          }),
    );
  }
}
