import 'package:flutter/material.dart';

class train_database_page extends StatefulWidget {
  const train_database_page({super.key});

  @override
  State<train_database_page> createState() => _train_database_pageState();
}

class _train_database_pageState extends State<train_database_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Train Database'),),
    );
  }
}
