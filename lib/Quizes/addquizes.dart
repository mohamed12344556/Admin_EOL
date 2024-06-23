import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/const/link.dart';

class AddQuizPage extends StatefulWidget {
  @override
  _AddQuizPageState createState() => _AddQuizPageState();
}

class _AddQuizPageState extends State<AddQuizPage> {
  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _rightAnswerController = TextEditingController();
  final TextEditingController _incorrectAnswer1Controller = TextEditingController();
  final TextEditingController _incorrectAnswer2Controller = TextEditingController();
  final TextEditingController _incorrectAnswer3Controller = TextEditingController();
  final TextEditingController _lessonIdController = TextEditingController();

  Future<void> _addQuizQuestion() async {
    final uri = Uri.parse(linkaddQuiz);
    final response = await http.post(
      uri,
      body: {
        'questiontext': _questionController.text,
        'rightanswer': _rightAnswerController.text,
        'incorrectanswer_1': _incorrectAnswer1Controller.text,
        'incorrectanswer_2': _incorrectAnswer2Controller.text,
        'incorrectanswer_3': _incorrectAnswer3Controller.text,
        'lessonid': _lessonIdController.text,
      },
    );

    if (response.statusCode == 200) {
      // Handle success
      print('Quiz question added successfully');
    } else {
      // Handle failure
      print('Failed to add quiz question');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Quiz Question'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _questionController,
              decoration: const InputDecoration(labelText: 'Question Text'),
            ),
            TextField(
              controller: _rightAnswerController,
              decoration: const InputDecoration(labelText: 'Right Answer'),
            ),
            TextField(
              controller: _incorrectAnswer1Controller,
              decoration: const InputDecoration(labelText: 'Incorrect Answer 1'),
            ),
            TextField(
              controller: _incorrectAnswer2Controller,
              decoration: const InputDecoration(labelText: 'Incorrect Answer 2'),
            ),
            TextField(
              controller: _incorrectAnswer3Controller,
              decoration: const InputDecoration(labelText: 'Incorrect Answer 3'),
            ),
            TextField(
              controller: _lessonIdController,
              decoration: const InputDecoration(labelText: 'Lesson ID'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addQuizQuestion,
              child: const Text('Add Quiz Question'),
            ),
          ],
        ),
      ),
    );
  }
}


