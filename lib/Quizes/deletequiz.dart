import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/const/link.dart';

class DeleteQuizPage extends StatefulWidget {
  @override
  _DeleteQuizPageState createState() => _DeleteQuizPageState();
}

class _DeleteQuizPageState extends State<DeleteQuizPage> {
  final TextEditingController _idController = TextEditingController();

  Future<void> _deleteQuizQuestion() async {
    final uri = Uri.parse(linkdeleteQuiz);
    final response = await http.post(
      uri,
      body: {
        'id': _idController.text,
      },
    );

    if (response.statusCode == 200) {
      // Handle success
      print('Quiz question deleted successfully');
    } else {
      // Handle failure
      print('Failed to delete quiz question');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delete Quiz Question'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _idController,
              decoration: const InputDecoration(labelText: 'Question ID'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _deleteQuizQuestion,
              child: const Text('Delete Quiz Question'),
            ),
          ],
        ),
      ),
    );
  }
}


