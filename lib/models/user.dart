class Employee {
  final int? id;
  final String name;
  final String position;
  final String? department;
  final double salary;
  final String hireDate;
  final String email;

  Employee({
    this.id,
    required this.name,
    required this.position,
    this.department,
    required this.salary,
    required this.hireDate,
    required this.email,
  });

  // Convert a Map into an Employee object
  factory Employee.fromMap(Map<String, dynamic> map) {
    return Employee(
      id: map['id'] as int?,
      name: map['name'] as String,
      position: map['position'] as String,
      department: map['department'] as String?,
      salary: map['salary'] as double,
      hireDate: map['hire_date'] as String,
      email: map['email'] as String,
    );
  }

  // Convert an Employee object into a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'position': position,
      'department': department,
      'salary': salary,
      'hire_date': hireDate,
      'email': email,
    };
  }
}
