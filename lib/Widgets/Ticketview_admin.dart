import 'package:flutter/material.dart';

class ticketView_admin extends StatelessWidget {
  final String source;
  final String destination;
  final String Train_class;
  final String type;
  final String date;
  final String train_time;
  final String seat;
  final String email;
  final String price;
  const ticketView_admin({super.key,required this.source,required this.destination,required this.Train_class,required this.type
    ,required this.date,required this.train_time,required this.seat,required this.email,required this.price,});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return SizedBox(
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.all(Radius.circular(16))
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text('Ticket'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(child: Image.asset('Assets/pic/barcode.png'),
                    height: height/4,
                    width: width/4,),
                  Container(
                    width: width/1.6,
                    child: Column(
                      children: [
                        Row(children: [Text('From : '),Text(source)],mainAxisAlignment: MainAxisAlignment.spaceBetween,),
                        Row(children: [Text('To : '),Text(destination)],mainAxisAlignment: MainAxisAlignment.spaceBetween),
                        Row(children: [Text('class :'),Text(Train_class)],mainAxisAlignment: MainAxisAlignment.spaceBetween),
                        Row(children: [Text('type :'),Text(type)],mainAxisAlignment: MainAxisAlignment.spaceBetween),
                        Row(children: [Text('date :'),Text(date)],mainAxisAlignment: MainAxisAlignment.spaceBetween),
                        Row(children: [Text('Train Time : '),Text(train_time)],mainAxisAlignment: MainAxisAlignment.spaceBetween,),
                        Row(children: [Text('seat : '),Text(seat)],mainAxisAlignment: MainAxisAlignment.spaceBetween),
                        Row(children: [Text('email :'),Text(email)],mainAxisAlignment: MainAxisAlignment.spaceBetween),
                        Row(children: [Text('Rs.',style: TextStyle(fontWeight: FontWeight.bold),),Text(price,style: TextStyle(fontWeight: FontWeight.bold),)]),
                      ],
                    ),
                  )],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
