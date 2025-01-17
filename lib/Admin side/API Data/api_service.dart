import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TrainFareInfo extends StatefulWidget {
  @override
  _TrainFareInfoState createState() => _TrainFareInfoState();
}

class _TrainFareInfoState extends State<TrainFareInfo> {
  String apiKey = 'a49ff048b2msh044d0fe52a68a70p1a6105jsn62534934482f';  // Replace with your actual RapidAPI key
  String apiHost = 'railway-trains-india.p.rapidapi.com';
  double? fare;  // Make sure the fare is of type `double?` for nullable

  Future<void> fetchFare() async {
    final String fromStation = 'ST';  // Surat station code
    final String toStation = 'BCT';  // Mumbai Central station code
    final String date = '2024-09-15';  // Example journey date (yyyy-mm-dd)

    final response = await http.get(
      Uri.parse('https://$apiHost/fare/$fromStation/$toStation/$date'),
      headers: {
        'x-rapidapi-key': apiKey,
        'x-rapidapi-host': apiHost,
      },
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print(data);  // Print the entire response to check its structure

      // Parse fare based on the actual structure of the data
      setState(() {
        fare = double.tryParse(data['fare']?.toString() ?? '0');  // Adjust this based on the actual key in response
      });

    } else {
      print('Failed to load fare information. Status Code: ${response.statusCode}');
    }
  }


  @override
  void initState() {
    super.initState();
    fetchFare();  // Fetch fare between Surat and Mumbai
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Train Fare Info')),
      body: Center(
        child: fare != null
            ? Text('Fare from Surat to Mumbai: ₹${fare!.toStringAsFixed(2)}')  // Use the null-assertion operator "!" to guarantee non-null
            : Text('Fetching fare data...'),
      ),
    );
  }
}
