import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/const/link.dart';

class SubjectsPage extends StatefulWidget {
  @override
  _SubjectsPageState createState() => _SubjectsPageState();
}

class _SubjectsPageState extends State<SubjectsPage> {
  List subjects = [];

  @override
  void initState() {
    super.initState();
    fetchSubjects();
  }

  fetchSubjects() async {
    final response = await http.get(Uri.parse(linkviewsubject));

    if (response.statusCode == 200) {
      setState(() {
        var data = json.decode(response.body);
        subjects = data['data']; // Extract the list from the 'data' key
      });
    } else {
      throw Exception('Failed to load subjects');
    }
  }

  String encodeFileName(String fileName) {
    return Uri.encodeComponent(fileName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Subjects'),
      ),
      body: subjects.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Card(
              child: ListView.builder(
                itemCount: subjects.length,
                itemBuilder: (context, index) {
                  String encodedFileName = encodeFileName(subjects[index]['subjects_image']);
                  return ListTile(
                    title: Text(subjects[index]['subjects_name']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Subject ID: ${subjects[index]['subjects_id']}'),
                        SizedBox(height: 10),
                        Text('Department: ${subjects[index]['subjects_departments']}'),
                      ],
                    ),
                    leading: Image.network(
                      '$linkServerName/upload/$encodedFileName',
                      errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                        return Image.asset('assets/images/default.png'); // الصورة الافتراضية
                      },
                    ),
                  );
                },
              ),
            ),
    );
  }
}
