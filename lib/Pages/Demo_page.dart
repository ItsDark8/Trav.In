import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class demo_page extends StatefulWidget {
  const demo_page({super.key});

  @override
  State<demo_page> createState() => _demo_pageState();
}

class _demo_pageState extends State<demo_page> {
  List<Map<String, dynamic>> _stationData = []; // List to store station data
  String? _selectedSourceStation;
  String? _selectedDestinationStation;
  int? _totalPrice;
  final TextEditingController _toStation = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadStationData(); // Load station names and prices from JSON on initialization
  }

  // Method to load the JSON file and parse the station names and prices
  Future<void> _loadStationData() async {
    final String response = await rootBundle.loadString('Assets/railway_station.json');
    final Map<String, dynamic> data = jsonDecode(response); // Decode the JSON
    setState(() {
      _stationData = List<Map<String, dynamic>>.from(data['train_stations']);
    });
  }

  // Method to find the price of the selected station
  int? _getPriceForStation(String stationName) {
    for (var station in _stationData) {
      if (station['station_name'] == stationName) {
        return station['price'];
      }
    }
    return null;
  }

  // Method to calculate the total price
  void _calculateTotalPrice() {
    if (_selectedSourceStation != null && _selectedDestinationStation != null) {
      final sourcePrice = _getPriceForStation(_selectedSourceStation!);
      final destinationPrice = _getPriceForStation(_selectedDestinationStation!);

      if (sourcePrice != null && destinationPrice != null) {
        setState(() {
          _totalPrice = sourcePrice + destinationPrice;
        });
      }
    } else {
      // If stations are not selected, show an error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select both source and destination stations')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> stationNames = _stationData.map((station) => station['station_name'] as String).toList();

    return Scaffold();
  }
}