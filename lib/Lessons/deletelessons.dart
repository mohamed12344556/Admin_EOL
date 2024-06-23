import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/const/link.dart';

class DeleteLessonPage extends StatefulWidget {
  @override
  _DeleteLessonPageState createState() => _DeleteLessonPageState();
}

class _DeleteLessonPageState extends State<DeleteLessonPage> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _pdfNameController = TextEditingController();

  Future<void> _deleteLesson() async {
    final uri = Uri.parse(linkdeletelesson);
    final response = await http.post(
      uri,
      body: {
        'id': _idController.text,
        'pdfname': _pdfNameController.text,
      },
    );

    if (response.statusCode == 200) {
      // Handle success
      print('Lesson deleted successfully');
    } else {
      // Handle failure
      print('Failed to delete lesson');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delete Lesson'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _idController,
              decoration: const InputDecoration(labelText: 'Lesson ID'),
            ),
            TextField(
              controller: _pdfNameController,
              decoration: const InputDecoration(labelText: 'PDF Name'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _deleteLesson,
              child: const Text('Delete Lesson'),
            ),
          ],
        ),
      ),
    );
  }
}


