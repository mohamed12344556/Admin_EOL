import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/const/link.dart'; // Adjust import as per your project structure

class ViewQuizes extends StatefulWidget {
  @override
  _ViewQuizesState createState() => _ViewQuizesState();
}

class _ViewQuizesState extends State<ViewQuizes> {
  List<Map<String, dynamic>> quizes = [];

  @override
  void initState() {
    super.initState();
    fetchQuizes();
  }

 fetchQuizes() async {
    try {
      final response = await http.get(Uri.parse(linkviewQuiz));

      if (response.statusCode == 200) {
        setState(() {
          var responseData = json.decode(response.body);
          if (responseData['status'] == 'success') {
            quizes = List<Map<String, dynamic>>.from(responseData['data']);
            // Print the list here
            print('Quizes List: $quizes');
          } else {
            throw Exception('Failed to load quizes');
          }
        });
      } else {
        throw Exception('Failed to load quizes');
      }
    } catch (e) {
      throw Exception('Failed to load quizes (Exception: $e)');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quizes'),
      ),
      body: quizes.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: quizes.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(quizes[index]['questions_text'] ?? 'N/A'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            'Question ID: ${quizes[index]['questions_id'] ?? 'N/A'}'),
                        const SizedBox(height: 2),
                        Text(
                            'Lesson ID: ${quizes[index]['questions_lessons'] ?? 'N/A'}'),
                        const SizedBox(height: 2),
                        Text(
                            'Right Answer: ${quizes[index]['right_answer'] ?? 'N/A'}'),
                        const SizedBox(height: 2),
                        Text(
                            'Incorrect Answer 1: ${quizes[index]['incorrect_answer_1'] ?? 'N/A'}'),
                        const SizedBox(height: 2),
                        Text(
                            'Incorrect Answer 2: ${quizes[index]['incorrect_answer_2'] ?? 'N/A'}'),
                        const SizedBox(height: 2),
                        Text(
                            'Incorrect Answer 3: ${quizes[index]['incorrect_answer_3'] ?? 'N/A'}'),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
