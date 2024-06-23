import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/const/link.dart';

class UpdateUnitPage extends StatefulWidget {
  @override
  _UpdateUnitPageState createState() => _UpdateUnitPageState();
}

class _UpdateUnitPageState extends State<UpdateUnitPage> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _subjectIdController = TextEditingController();

  Future<void> _updateUnit() async {
    final String id = _idController.text;
    final String name = _nameController.text;
    final String subjectId = _subjectIdController.text;

    final response = await http.post(
      Uri.parse(linkupdateunits),
      body: {
        'id': id,
        'name': name,
        'subjectid': subjectId,
      },
    );

    final responseBody = json.decode(response.body);

    if (responseBody['status'] == 'success') {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Unit updated successfully')));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Failed to update unit')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Update Unit')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _idController,
              decoration: const InputDecoration(labelText: 'Unit ID'),
            ),
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
              onPressed: _updateUnit,
              child: const Text('Update Unit'),
            ),
          ],
        ),
      ),
    );
  }
}
