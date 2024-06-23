import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:untitled/const/link.dart';

class DeleteSubjectScreen extends StatefulWidget {
  @override
  _DeleteSubjectScreenState createState() => _DeleteSubjectScreenState();
}

class _DeleteSubjectScreenState extends State<DeleteSubjectScreen> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _imageNameController = TextEditingController();

  Future<void> _deleteSubject() async {
    final id = _idController.text;
    final imageName = _imageNameController.text;

    if (id.isEmpty || imageName.isEmpty) {
      // Display error message
      return;
    }

    final response = await http.post(
      Uri.parse(linkdeletesubject),
      body: {
        'id': id,
        'imagename': imageName,
      },
    );

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      // Handle successful response
      print('Subject deleted successfully');
    } else {
      // Handle error response
      print('Failed to delete subject');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delete Subject'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _idController,
              decoration: const InputDecoration(labelText: 'Subject ID'),
            ),
            TextField(
              controller: _imageNameController,
              decoration: const InputDecoration(labelText: 'Image Name'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _deleteSubject,
              child: const Text('Delete'),
            ),
          ],
        ),
      ),
    );
  }
}
