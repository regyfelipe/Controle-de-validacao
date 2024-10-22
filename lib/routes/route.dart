import 'package:cvp/screens/loja/loja_screen.dart';
import 'package:flutter/material.dart';
import '../screens/categoria/categoria_screen.dart';
import '../screens/adicionar/add_screen.dart';
import '../screens/marca/marca_screen.dart';
import '../screens/splash_screen.dart';
import '../utils/main.dart'; 

class AppRoutes {
  static const String splash = '/';
  static const String home = '/home';
  static const String categoria = '/categoria';
  static const String add = '/add';
  static const String marca = '/marca';
  static const String menu = '/loja';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case home:
        return MaterialPageRoute(builder: (_) => MainScreen()); 
      case categoria:
        return MaterialPageRoute(builder: (_) => CategoriaScreen());
      case add:
        return MaterialPageRoute(builder: (_) => AddScreen());
      case marca:
        return MaterialPageRoute(builder: (_) => MarcaScreen());
      case menu:
        return MaterialPageRoute(builder: (_) => LojaScreen());
      default:
        return MaterialPageRoute(builder: (_) => SplashScreen());
    }
  }
}
