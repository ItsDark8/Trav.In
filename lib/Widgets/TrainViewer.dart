import 'package:flutter/material.dart';

class TrainViewer extends StatelessWidget {

  final String Destination;
  final String Soures;
  final String TimeOfTrain;
  final String Price;

  const TrainViewer({Key? key,required this.Soures,required this.Destination,
  required this.TimeOfTrain,required this.Price}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(18)),
            border: Border.all(
                color: Colors.black,
                width: 1
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(
                  width: 80,
                  child: Image.asset('Assets/Icons/train-toon_icon.png'),
                ),
                SizedBox(width: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('From : $Soures',),
                    Text('To : $Destination'),
                    Text('Time : $TimeOfTrain'),
                    Text('Price : $Price')
                  ],
                )
              ],
            ),
          ),
        ),
      );
  }
}