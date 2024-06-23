import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/const/link.dart';

class UpdateDepartmentPage extends StatefulWidget {
  @override
  _UpdateDepartmentPageState createState() => _UpdateDepartmentPageState();
}

class _UpdateDepartmentPageState extends State<UpdateDepartmentPage> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  Future<void> _updateDepartment() async {
    final uri = Uri.parse(linkupdatedep);
    final response = await http.post(
      uri,
      body: {
        'id': _idController.text,
        'name': _nameController.text,
      },
    );

    if (response.statusCode == 200) {
      // Handle success
      print('Department updated successfully');
    } else {
      // Handle failure
      print('Failed to update department');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Department'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _idController,
              decoration: const InputDecoration(labelText: 'Department ID'),
            ),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Department Name'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateDepartment,
              child: const Text('Update Department'),
            ),
          ],
        ),
      ),
    );
  }
}
