import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/const/link.dart';

class AddDepartmentPage extends StatefulWidget {
  @override
  _AddDepartmentPageState createState() => _AddDepartmentPageState();
}

class _AddDepartmentPageState extends State<AddDepartmentPage> {
  final TextEditingController _nameController = TextEditingController();

  Future<void> _addDepartment() async {
    final uri = Uri.parse(linkadddep);
    final response = await http.post(
      uri,
      body: {
        'name': _nameController.text,
      },
    );

    if (response.statusCode == 200) {
      // Handle success
      print('Department added successfully');
    } else {
      // Handle failure
      print('Failed to add department');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Department'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Department Name'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addDepartment,
              child: const Text('Add Department'),
            ),
          ],
        ),
      ),
    );
  }
}


