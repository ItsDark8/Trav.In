import 'package:flutter/material.dart';
import 'package:trav_in/Pages/TIcket%20Booking/tab_pages/bill_page.dart';
import 'package:trav_in/Widgets/TrainViewer.dart';

class train_select_page extends StatefulWidget {
  final String fromStation;
  final String toStation;
  final String date;
  final String train_class;
  final String type;
  final seat;
  final price;
  const train_select_page({super.key,required this.fromStation,required this.toStation,required this.date,
    required this.seat,required this.train_class,required this.type,required this.price});

  @override
  State<train_select_page> createState() => _train_select_pageState();
}

List<String> train_time= ['6H:30M','14H:00M','18H:30M'];

class _train_select_pageState extends State<train_select_page> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Train'),
        centerTitle: true,
      ),
      body: Column(
        children: [
        Text('Date:'+widget.date,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
          SizedBox(
            height: 380,
            child: ListView.builder(
                itemCount: 3 ,
                itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  child: TrainViewer(
                    Soures: widget.fromStation,
                    Destination: widget.toStation,
                    TimeOfTrain: train_time[index],
                    Price: widget.price),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>bill_page(fromStation: widget.fromStation, toStation: widget.toStation, price: widget.price,date: widget.date,seat: widget.seat,train_time: train_time[index],train_class: widget.train_class,type: widget.type,)));
                },
                );
                }),
          ),
        ],
      )
    );
  }
}
