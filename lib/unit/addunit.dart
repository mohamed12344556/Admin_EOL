import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/const/link.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Add Unit',
      home: AddUnitPage(),
    );
  }
}

class AddUnitPage extends StatefulWidget {
  @override
  _AddUnitPageState createState() => _AddUnitPageState();
}

class _AddUnitPageState extends State<AddUnitPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _subjectIdController = TextEditingController();

  Future<void> _addUnit() async {
    final String name = _nameController.text;
    final String subjectId = _subjectIdController.text;

    final response = await http.post(
      Uri.parse(linkaddunits),
      body: {
        'name': name,
        'subjectid': subjectId,
      },
    );

    final responseBody = json.decode(response.body);

    if (responseBody['status'] == 'success') {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Unit added successfully')));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Failed to add unit')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Unit')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Unit Name'),
            ),
            TextField(
              controller: _subjectIdController,
              decoration: const InputDecoration(labelText: 'Subject ID'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addUnit,
              child: const Text('Add Unit'),
            ),
          ],
        ),
      ),
    );
  }
}
