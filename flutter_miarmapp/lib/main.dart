import 'package:flutter/material.dart';
import 'package:flutter_miarmapp/screens/home_screen.dart';
import 'package:flutter_miarmapp/screens/login_screen.dart';
import 'package:flutter_miarmapp/screens/menu_screen.dart';
import 'package:flutter_miarmapp/screens/profile_screen.dart';
import 'package:flutter_miarmapp/screens/register_screen.dart';
import 'package:flutter_miarmapp/screens/search_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MiarmApp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login',
      routes: {
        '/': (context) => const MenuScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/search': (context) => const SearchScreen(),
        '/home': (context) => const HomeScreen(),
        '/profile': (context) => const ProfileScreen(),
      },
    );
  }
}
