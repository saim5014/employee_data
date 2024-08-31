// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_application_sqflite/db/database_helper.dart';
import 'package:flutter_application_sqflite/models/user.dart';

class UpdateEmployeeScreen extends StatefulWidget {
  final Employee employee;

  const UpdateEmployeeScreen({super.key, required this.employee});

  @override
  _UpdateEmployeeScreenState createState() => _UpdateEmployeeScreenState();
}

class _UpdateEmployeeScreenState extends State<UpdateEmployeeScreen> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  late TextEditingController _nameController;
  late TextEditingController _positionController;
  late TextEditingController _departmentController;
  late TextEditingController _salaryController;
  late TextEditingController _hireDateController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.employee.name);
    _positionController = TextEditingController(text: widget.employee.position);
    _departmentController =
        TextEditingController(text: widget.employee.department ?? '');
    _salaryController =
        TextEditingController(text: widget.employee.salary.toString());
    _hireDateController = TextEditingController(text: widget.employee.hireDate);
    _emailController = TextEditingController(text: widget.employee.email);
  }

  Future<void> _updateEmployee() async {
    final updatedEmployee = Employee(
      id: widget.employee.id,
      name: _nameController.text,
      position: _positionController.text,
      department: _departmentController.text.isEmpty
          ? null
          : _departmentController.text,
      salary: double.tryParse(_salaryController.text) ?? 0,
      hireDate: _hireDateController.text,
      email: _emailController.text,
    );
    await _dbHelper.updateEmployee(updatedEmployee);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Employee'),
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
              onPressed: _updateEmployee,
              child: const Text('Update Employee'),
            ),
          ],
        ),
      ),
    );
  }
}
