import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class user_info_page extends StatefulWidget {
  const user_info_page({super.key});

  @override
  State<user_info_page> createState() => _user_info_pageState();
}

class _user_info_pageState extends State<user_info_page> {

  deleteData(u_id){
    FirebaseFirestore.instance.collection('Users').doc(u_id).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Database'),),
      body: StreamBuilder(stream: FirebaseFirestore.instance.collection('Users').snapshots(),
        builder: (context,dataInfo){
        if(dataInfo.connectionState == ConnectionState.active){
          if(dataInfo.hasData){
            return ListView.builder(
                itemBuilder: (context,index){
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(16))
                  ),
                  child: ListTile(
                    leading: CircleAvatar(child:Text("${index+1}"),backgroundColor: Colors.blue,),
                    title: Text("${dataInfo.data!.docs[index]['u_firstname']}"),
                    subtitle: Text("${dataInfo.data!.docs[index]['u_email']}"),
                    trailing: IconButton(icon: Icon(Icons.delete_rounded),color: Colors.red,onPressed: (){
                      deleteData(dataInfo.data!.docs[index]['u_id']);},),
                  ),
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
