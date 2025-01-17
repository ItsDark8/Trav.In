import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:trav_in/Theme/ColorFile.dart';
class TicketView extends StatelessWidget {

  final String Source_State;
  final String Destination_State;
  final String Source_City;
  final String Destination_City;
  final String Train_Time;
  final String Department_time;
  final String Ticket_Date;
  final int Seat_number;

   TicketView({Key? key,required this.Source_State,required this.Destination_State,
   required this.Source_City,required this.Destination_City,required this.Department_time,
   required this.Seat_number,required this.Ticket_Date,required this.Train_Time,
   }):super(key: key);


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 189,
      width: 340,
      child: Container(
        child: Column(
          children: [
            Container(
              //margin: EdgeInsets.only(right: 10),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColor.TicketGrey,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(21),topRight: Radius.circular(21))
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                     SizedBox(
                       width: 50,
                       child: Column(
                         children: [
                           Row(
                             children: [
                               Text(Source_State,style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),),
                             ],
                           ),
                           Row(
                             children: [
                               Text(Source_City,style: TextStyle(color: Colors.white,fontSize: 13),),
                             ],
                           ),
                         ],
                       ),
                     ),
                      SizedBox(
                        child: Column(
                          children: [
                            SizedBox(
                              child: Row(
                                children: [
                                  ImageIcon(AssetImage('Assets/Icons/Cricle.png'),size: 10,color: Colors.white,),
                                  SizedBox(child: ImageIcon(AssetImage('Assets/Icons/trainPathicon.png'),color: Colors.white,),width: 60,height: 10,),
                                  ImageIcon(AssetImage('Assets/Icons/Cricle.png'),size: 10,color: Colors.white,),
                                ],
                              ),
                              height: 20,
                            ),
                            Text(Train_Time,style: TextStyle(color: Colors.white),),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 50,
                        child: Column(
                          children: [
                            Row(
                              textDirection: TextDirection.rtl,
                              children: [
                                Text(Destination_State,style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),),
                              ],
                            ),
                            Row(
                              textDirection: TextDirection.rtl,
                              children: [
                                Text(Destination_City,style: TextStyle(color: Colors.white,fontSize: 13),),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Container(height: 20,
            color: Colors.blue,
              child: Row(
                children: [
                  Container(
                    height: 20,
                    width: 10,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),bottomRight: Radius.circular(20),),
                      color: Theme.of(context).colorScheme.background
                    ),
                  ),
                  Expanded(child: Container(child: Text('-  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -',style: TextStyle(color: Colors.white),),)),
                  Container(
                    height: 20,
                    width: 10,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),bottomLeft: Radius.circular(20),),
                        color: Theme.of(context).colorScheme.background
                    ),
                  )
                ],
              ),
            ),
            Container(
              //margin: EdgeInsets.only(right: 10),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(21),bottomRight: Radius.circular(21))
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 50,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(Ticket_Date,style: TextStyle(fontSize: 16,color: Colors.white,),),
                              ],
                            ),
                            Row(
                              children: [
                                Text('Date',style: TextStyle(color: Colors.white),),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        child: Column(
                          children: [
                            Text(Department_time,style: TextStyle(fontSize: 14,color: Colors.white,),),
                            Text('Departure time',style: TextStyle(color: Colors.white),),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 50,
                        child: Column(
                          children: [
                            Row(
                              textDirection: TextDirection.rtl,
                              children: [
                                Text(Seat_number.toString(),style: TextStyle(fontSize: 16,color: Colors.white,),),
                              ],
                            ),
                            Row(
                              textDirection: TextDirection.rtl,
                              children: [
                                Text('Seat',style: TextStyle(color: Colors.white),),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
