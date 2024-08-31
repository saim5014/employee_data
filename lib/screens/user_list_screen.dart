// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_application_sqflite/models/user.dart';
import 'package:flutter_application_sqflite/screens/update_screen.dart';
import 'package:flutter_application_sqflite/screens/user.dart';
import '../db/database_helper.dart';

class EmployeeListScreen extends StatefulWidget {
  const EmployeeListScreen({super.key});

  @override
  _EmployeeListScreenState createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  late Future<List<Employee>> futureEmployees;

  @override
  void initState() {
    super.initState();
    futureEmployees = DatabaseHelper().getEmployees();
  }

  Future<void> _deleteEmployee(int id) async {
    await DatabaseHelper().deleteEmployee(id);
    setState(() {
      futureEmployees =
          DatabaseHelper().getEmployees(); // Refresh the employee list
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.pushNamed(context, '/search');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<Employee>>(
              future: futureEmployees,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No employees found.'));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final employee = snapshot.data![index];
                      return ListTile(
                        title: Text(employee.name),
                        subtitle: Text(employee.email),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UpdateEmployeeScreen(
                                        employee: employee),
                                  ),
                                ).then((_) => setState(() {
                                      futureEmployees =
                                          DatabaseHelper().getEmployees();
                                    }));
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => _deleteEmployee(employee.id!),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      const EmployeeScreen(), // Navigate to EmployeeScreen
                ),
              );
            },
            child: const Text('Add New Employee'),
          ),
        ],
      ),
    );
  }
}
