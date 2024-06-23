import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/const/link.dart';

class ViewLessonsPage extends StatefulWidget {
  @override
  _ViewLessonsPageState createState() => _ViewLessonsPageState();
}

class _ViewLessonsPageState extends State<ViewLessonsPage> {
  List lessons = [];
  String errorMessage = ''; // Variable to store error message

  @override
  void initState() {
    super.initState();
    fetchLessons();
  }

  fetchLessons() async {
    try {
      // Replace 'linkviewsubject' with your actual API endpoint
      final response = await http.get(Uri.parse(linkviewlesson));

      if (response.statusCode == 200) {
        setState(() {
          lessons = json.decode(response.body)['data'];
        });
      } else {
        setState(() {
          errorMessage = 'Failed to load lessons (${response.statusCode})';
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to load lessons (Exception: $e)';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lessons'),
      ),
      body: errorMessage.isNotEmpty // Show error message if not empty
          ? Center(
              child: Text(
                errorMessage,
                style: TextStyle(fontSize: 18, color: Colors.red),
              ),
            )
          : lessons.isEmpty
              ? const Center(
                  child: CircularProgressIndicator()) // Show loading indicator
              : ListView.builder(
                  itemCount: lessons.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(lessons[index]['lessons_name']),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Lesson ID: ${lessons[index]['lessons_id']}'),
                            const SizedBox(height: 2),
                            Text(
                                'Video URL: ${lessons[index]['lessons_video_url']}'),
                            const SizedBox(height: 2),
                            Text('PDF: ${lessons[index]['lessons_pdf']}'),
                            const SizedBox(height: 2),
                            Text('Units: ${lessons[index]['lessons_units']}'),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
