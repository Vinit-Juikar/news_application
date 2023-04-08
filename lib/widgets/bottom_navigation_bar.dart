import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../pages/main_news_homescreen.dart';

class BottomNavigationBarForHomeScreen extends StatefulWidget {
  const BottomNavigationBarForHomeScreen({super.key});

  @override
  State<BottomNavigationBarForHomeScreen> createState() =>
      _BottomNavigationBarForHomeScreenState();
}

class _BottomNavigationBarForHomeScreenState
    extends State<BottomNavigationBarForHomeScreen> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    NewsHomeScreen(),
    // Add your other screens here
    PlaceholderWidget(Colors.green),
    PlaceholderWidget(Colors.blue),
    PlaceholderWidget(Colors.yellow),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: const Color.fromARGB(255, 40, 39, 39),
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home, color: Colors.white),
          label: 'Home',
          backgroundColor: Colors.white,
        ),
        // Add your other bottom navigation items here
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite, color: Colors.white),
          label: 'Favorites',
          backgroundColor: Colors.white,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search, color: Colors.white),
          label: 'Search',
          backgroundColor: Colors.white,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person, color: Colors.white),
          label: 'Profile',
          backgroundColor: Colors.white,
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.white,
      onTap: _onItemTapped,
      type: BottomNavigationBarType.fixed,
      selectedIconTheme: IconThemeData(color: Colors.blue),
    );
  }
}

class PlaceholderWidget extends StatelessWidget {
  final Color color;

  const PlaceholderWidget(this.color, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
    );
  }
}
