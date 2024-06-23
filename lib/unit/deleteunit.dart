import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/const/link.dart';

class DeleteUnitPage extends StatefulWidget {
  @override
  _DeleteUnitPageState createState() => _DeleteUnitPageState();
}

class _DeleteUnitPageState extends State<DeleteUnitPage> {
  final TextEditingController _idController = TextEditingController();

  Future<void> _deleteUnit() async {
    final String id = _idController.text;

    final response = await http.post(
      Uri.parse(linkdeleteunits),
      body: {
        'id': id,
      },
    );

    final responseBody = json.decode(response.body);

    if (responseBody['status'] == 'success') {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Unit deleted successfully')));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Failed to delete unit')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Delete Unit')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _idController,
              decoration: const InputDecoration(labelText: 'Unit ID'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _deleteUnit,
              child: const Text('Delete Unit'),
            ),
          ],
        ),
      ),
    );
  }
}
