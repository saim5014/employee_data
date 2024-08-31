// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_application_sqflite/models/user.dart';
import 'package:flutter_application_sqflite/screens/user_list_screen.dart';
import '../db/database_helper.dart';

class EmployeeScreen extends StatefulWidget {
  const EmployeeScreen({super.key});

  @override
  _EmployeeScreenState createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _positionController = TextEditingController();
  final TextEditingController _departmentController = TextEditingController();
  final TextEditingController _salaryController = TextEditingController();
  final TextEditingController _hireDateController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  Future<void> _addEmployee() async {
    final name = _nameController.text;
    final position = _positionController.text;
    final department =
        _departmentController.text.isEmpty ? null : _departmentController.text;
    final salary = double.tryParse(_salaryController.text) ?? 0;
    final hireDate = _hireDateController.text;
    final email = _emailController.text;

    if (name.isNotEmpty &&
        position.isNotEmpty &&
        salary > 0 &&
        hireDate.isNotEmpty &&
        email.isNotEmpty) {
      final employee = Employee(
        name: name,
        position: position,
        department: department,
        salary: salary,
        hireDate: hireDate,
        email: email,
      );
      await _dbHelper.insertEmployee(employee);
      _nameController.clear();
      _positionController.clear();
      _departmentController.clear();
      _salaryController.clear();
      _hireDateController.clear();
      _emailController.clear();
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Employee'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _positionController,
              decoration: const InputDecoration(labelText: 'Position'),
            ),
            TextField(
              controller: _departmentController,
              decoration: const InputDecoration(labelText: 'Department'),
            ),
            TextField(
              controller: _salaryController,
              decoration: const InputDecoration(labelText: 'Salary'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _hireDateController,
              decoration: const InputDecoration(labelText: 'Hire Date'),
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addEmployee,
              child: const Text('Add Employee'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        const EmployeeListScreen(), // Navigate to EmployeeListScreen
                  ),
                );
              },
              child: const Text('View All Employees'),
            ),
          ],
        ),
      ),
    );
  }
}
