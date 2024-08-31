import 'package:flutter/material.dart';
import 'package:flutter_application_sqflite/screens/search_user.dart';
import 'package:flutter_application_sqflite/screens/user.dart';
import 'package:flutter_application_sqflite/screens/user_list_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Employee Management',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const EmployeeScreen(),
        '/employees': (context) => const EmployeeListScreen(),
        '/search': (context) => const SearchScreen(),
      },
    );
  }
}
