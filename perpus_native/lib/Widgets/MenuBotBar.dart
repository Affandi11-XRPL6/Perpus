import 'package:flutter/material.dart';

class MenuBotBar extends StatefulWidget { 
  const MenuBotBar({super.key});

  @override
  _MenuBotBarState createState() => _MenuBotBarState(); 
}

class _MenuBotBarState extends State<MenuBotBar> { 
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() { 
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      selectedItemColor: Color.fromARGB(255, 93, 196, 255),
      unselectedItemColor: const Color.fromARGB(236, 151, 151, 151),
      showSelectedLabels: true,
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
        BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favorite"),
      ],
    );
  }
}
