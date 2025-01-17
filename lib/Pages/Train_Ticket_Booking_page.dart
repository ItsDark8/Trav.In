import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trav_in/Pages/TIcket%20Booking/tab_pages/Train_select_page.dart';
import '../../../Widgets/BottomNavigation.dart';

class ticket_booking_page extends StatefulWidget {
  const ticket_booking_page({super.key});

  @override
  State<ticket_booking_page> createState() => _ticket_booking_page();
}

class _ticket_booking_page extends State<ticket_booking_page> {
  final TextEditingController _fromStation = TextEditingController();
  final TextEditingController _toStation = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _seat = TextEditingController();

  String _dropdownValue = 'All Classes'; // Set a default value
  String _dropdownValue1= 'General';
  final List<String> trainClass = [
    'All Classes',
    'First AC(1A)',
    'Second AC(2A)',
    'Third AC(3A)',
    'First Class(FC)',
    'Executive Class(EC)',
    'Chair Class(CC)',
    'Second Seating(2S)',
    'Sleeper'
  ];
  final List<String> ticket_type = [
    'General','Ladies','Lower Berth/Sr.Citizen','Person with Disability','Duty Pass','Tatkal','Premium Tatkal'
  ];

  List<String> railwayStationNames = [];


  List<Map<String, dynamic>> _stationData = []; // List to store station data
  String? _selectedSourceStation;
  String? _selectedDestinationStation;
  int? _totalPrice;

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
        SnackBar(content: Text('station not found')),
      );
    }
  }


  Future<void> _selectDate() async {
    DateTime? _datepicker = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (_datepicker != null) {
      setState(() {
        _dateController.text = _datepicker.toLocal().toString().split(" ")[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> stationNames = _stationData.map((station) => station['station_name'] as String).toList();
    return Container(
        decoration: BoxDecoration(
        image: DecorationImage(
        image: AssetImage('Assets/pic/mainPic.jpg'),
    fit: BoxFit.fill
    ),
    ),
    child: Scaffold(
      appBar: AppBar(
        title: Text('Train Ticket Booking',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.push(
              context, MaterialPageRoute(builder: (context) => bottomnavigation()));
          },
        ),
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue.withAlpha(200),
                  borderRadius: BorderRadius.all(Radius.circular(21))
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      Autocomplete<String>(
                        optionsBuilder: (TextEditingValue textEditingValue) {
                          if (textEditingValue.text.isEmpty) {
                            return const Iterable<String>.empty();
                          }
                          return stationNames.where((String stationName) {
                            return stationName.toLowerCase().contains(textEditingValue.text.toLowerCase());
                          });
                        },
                        onSelected: (String selection) {
                          setState(() {
                            _selectedSourceStation = selection; // Set the source station
                            _fromStation.text = selection; // Update text field controller
                          });
                        },
                        fieldViewBuilder: (BuildContext context, TextEditingController fieldTextController, FocusNode focusNode, VoidCallback onFieldSubmitted) {
                          return TextField(
                            controller: fieldTextController,
                            focusNode: focusNode,
                            decoration: InputDecoration(
                              label: Text('From'),
                              fillColor: Colors.white,
                              filled: true,
                              prefixIcon: RotatedBox(quarterTurns: 30, child: Icon(Icons.send)),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          );
                        },
                      ),

                      Icon(Icons.compare_arrows, color: Colors.black),
                      Autocomplete<String>(
                        optionsBuilder: (TextEditingValue textEditingValue) {
                          if (textEditingValue.text.isEmpty) {
                            return const Iterable<String>.empty();
                          }
                          return stationNames.where((String stationName) {
                            return stationName.toLowerCase().contains(textEditingValue.text.toLowerCase());
                          });
                        },
                        onSelected: (String selection) {
                          setState(() {
                            _selectedDestinationStation = selection;
                            _toStation.text = selection;
                          });
                        },
                        fieldViewBuilder: (BuildContext context, TextEditingController _toStation, FocusNode focusNode, VoidCallback onFieldSubmitted) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: TextField(
                                controller: _toStation,
                                focusNode: focusNode,
                                decoration: InputDecoration(
                                  label: Text('To'),
                                  fillColor: Colors.white,
                                  filled: true,
                                  prefixIcon: Icon(Icons.place),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),

        
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: _dateController,
                          decoration: InputDecoration(
                            label: Text('DD/MM/YYYY'),
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: Icon(Icons.calendar_today_outlined),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          readOnly: true,
                          onTap: _selectDate,
                        ),
                      ),
                      SizedBox(height: 10),
        
                      //DropDownList for trainclass selection
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  width: 1,
                                  color: Colors.black
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(18))
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: DropdownButton<String>(
                              value: _dropdownValue,
                              isExpanded: true,
                              borderRadius: BorderRadius.all(Radius.circular(21)),
                              hint: Text('Select Class'),
                              onChanged: (String? newValue) {
                                setState(() {
                                  _dropdownValue = newValue ?? 'All Classes';
                                });
                              },
                              items: trainClass.map((String item) {
                                return DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(item),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
        
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  width: 1,
                                  color: Colors.black
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(18))
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: DropdownButton<String>(
                              value: _dropdownValue1,
                              isExpanded: true,
                              hint: Text('select type'),
                              borderRadius: BorderRadius.all(Radius.circular(21)),
                              onChanged: (String? newValue) {
                                setState(() {
                                  _dropdownValue1 = newValue ?? 'General';
                                });
                              },
                              items: ticket_type.map((String item) {
                                return DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(item),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: TextFormField(
                            controller: _seat,
                            decoration: InputDecoration(
                              label: Text('Number Of Seats'),
                              fillColor: Colors.white,
                              filled: true,
                              prefixIcon: Icon(Icons.event_seat),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                        ),
                      ),
        
                      SizedBox(height: 10),
        
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          child: Container(
                            child: Center(
                              child: Text(
                                'Search',
                                style: TextStyle(color: Colors.black, fontSize: 15),
                              ),
                            ),
                            height: 62,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.white,
                            ),
                          ),
                          onTap: () {
                            _calculateTotalPrice();
                            Navigator.push(context, MaterialPageRoute(builder: (context) => train_select_page(
                              fromStation: _fromStation.text,
                              toStation: _toStation.text,
                              date: _dateController.text,
                              seat: _seat.text,train_class: _dropdownValue.toString(),
                              type: _dropdownValue1.toString(),
                              price: _totalPrice==null ? '350' : _totalPrice.toString(),
                            )));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    )
    );
  }
}