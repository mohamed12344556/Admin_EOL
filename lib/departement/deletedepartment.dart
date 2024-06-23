import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/const/link.dart';

class DeleteDepartmentPage extends StatefulWidget {
  @override
  _DeleteDepartmentPageState createState() => _DeleteDepartmentPageState();
}

class _DeleteDepartmentPageState extends State<DeleteDepartmentPage> {
  final TextEditingController _idController = TextEditingController();

  Future<void> _deleteDepartment() async {
    final uri = Uri.parse(linkdeletedep);
    final response = await http.post(
      uri,
      body: {
        'id': _idController.text,
      },
    );

    if (response.statusCode == 200) {
      // Handle success
      print('Department deleted successfully');
    } else {
      // Handle failure
      print('Failed to delete department');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delete Department'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _idController,
              decoration: const InputDecoration(labelText: 'Department ID'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _deleteDepartment,
              child: const Text('Delete Department'),
            ),
          ],
        ),
      ),
    );
  }
}

