import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Hotelviewer extends StatelessWidget {
  final String title;
  final String address;
  final Color bgcolor;
  final String rating;
  final String imageAddress;

  Hotelviewer({Key? key,required this.title,required this.address,
  required this.bgcolor,required this.rating,required this.imageAddress}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 330,
      width: 410,
      child: Container(
        child: Column(
          children: [
            Container(
              height: 238,
              decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(21),
                      topRight: Radius.circular(21))
              ),
              child: ClipRRect(
                  child: Image.asset(imageAddress,fit: BoxFit.fill,),
                  borderRadius: BorderRadius.only(topRight: Radius.circular(21),
                  topLeft: Radius.circular(21)),),
            ),
            Container(
              height: 83,
              decoration: BoxDecoration(
                  color: bgcolor,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(21),
                      bottomRight: Radius.circular(21))
              ),
              child: Padding(
                padding: const EdgeInsets.all(9.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(title,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 24),),
                        Row(
                          children: [
                            Text(rating,style: TextStyle(color: Colors.white,fontSize: 21),),
                            Text(' |',style: TextStyle(color: Colors.white),),
                            Icon(Icons.star,color: Colors.yellow,)
                          ],
                        )
                      ],
                    ),
                    Row(
                      textDirection: TextDirection.ltr,
                      children: [
                        Icon(Icons.location_on_outlined,size: 28,color: Colors.white,),
                        Text(address,style: TextStyle(color: Colors.white,fontSize: 21),),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
