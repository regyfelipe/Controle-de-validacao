import 'package:cvp/screens/loja/loja_screen.dart';
import 'package:flutter/material.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import '../screens/home/home_screen.dart';
import '../screens/categoria/categoria_screen.dart';
import '../screens/adicionar/add_screen.dart';
import '../screens/marca/marca_screen.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _selectedIndex = 0;

  static List<Widget> _screens = <Widget>[
    HomeScreen(),
    CategoriaScreen(),
    AddScreen(),
    MarcaScreen(),
    LojaScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(BootstrapIcons.house),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(BootstrapIcons.grid),
            label: 'Categoria',
          ),
          BottomNavigationBarItem(
            icon: Icon(BootstrapIcons.plus_circle),
            label: 'Adicionar',
          ),
          BottomNavigationBarItem(
            icon: Icon(BootstrapIcons.tags),
            label: 'Marca',
          ),
          BottomNavigationBarItem(
            icon: Icon(BootstrapIcons.shop),
            label: 'Lojas',
          ),
        ],
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
