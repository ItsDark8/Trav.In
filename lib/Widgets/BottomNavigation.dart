import 'package:flutter/material.dart';
import 'package:trav_in/Pages/Demo_page.dart';
import 'package:trav_in/Pages/History_page.dart';
import 'package:trav_in/Pages/Home_page.dart';
import 'package:trav_in/Pages/Profile_page.dart';

class bottomnavigation extends StatefulWidget {
  const bottomnavigation({super.key});

  @override
  State<bottomnavigation> createState() => _bottomnavigationState();
}

int _selectIndex = 0;
List<Widget> body = [
  home_page(),
  demo_page(),
  history_page(),
  profile_page()
];
class _bottomnavigationState extends State<bottomnavigation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body[_selectIndex],
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(icon: ImageIcon(AssetImage('Assets/flaticons/home.png'),),activeIcon: ImageIcon(AssetImage('Assets/flaticons/home (1).png')),label: 'Home'),
        BottomNavigationBarItem(icon: ImageIcon(AssetImage('Assets/flaticons/compass.png'),size: 24,),activeIcon: ImageIcon(AssetImage('Assets/flaticons/compass-circular-tool.png'),size: 24,),label: 'Train'),
        BottomNavigationBarItem(icon: ImageIcon(AssetImage('Assets/flaticons/history (1).png'),size: 20,),activeIcon: ImageIcon(AssetImage('Assets/flaticons/history.png'),size: 20,),label: 'History'),
        BottomNavigationBarItem(icon: ImageIcon(AssetImage('Assets/flaticons/user (1).png')),activeIcon: ImageIcon(AssetImage('Assets/flaticons/user.png')),label: 'Profile')
      ],
      type: BottomNavigationBarType.fixed,
      currentIndex: _selectIndex,
      backgroundColor: Colors.blue,
      unselectedItemColor: Colors.black,
      selectedItemColor: Colors.white,
      onTap: (int index){setState(() {
        _selectIndex = index;
        });},
      ),
    );
  }
}
