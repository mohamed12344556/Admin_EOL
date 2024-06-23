import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:untitled/const/link.dart';

class AddLessonPage extends StatefulWidget {
  @override
  _AddLessonPageState createState() => _AddLessonPageState();
}

class _AddLessonPageState extends State<AddLessonPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _unitIdController = TextEditingController();
  final TextEditingController _urlController = TextEditingController();
  File? _pdfFile;

  Future<void> _pickPDF() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
    if (result != null) {
      setState(() {
        _pdfFile = File(result.files.single.path!);
      });
    }
  }

  Future<void> _addLesson() async {
    final uri = Uri.parse(linkaddlesson);
    var request = http.MultipartRequest('POST', uri);
    request.fields['name'] = _nameController.text;
    request.fields['unitid'] = _unitIdController.text;
    request.fields['url'] = _urlController.text;
    if (_pdfFile != null) {
      request.files.add(await http.MultipartFile.fromPath('file', _pdfFile!.path));
    }

    var response = await request.send();

    if (response.statusCode == 200) {
      // Handle success
      print('Lesson added successfully');
    } else {
      // Handle failure
      print('Failed to add lesson');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Lesson'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Lesson Name'),
            ),
            TextField(
              controller: _unitIdController,
              decoration: const InputDecoration(labelText: 'Unit ID'),
            ),
            TextField(
              controller: _urlController,
              decoration: const InputDecoration(labelText: 'Video URL'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickPDF,
              child: const Text('Pick PDF'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addLesson,
              child: const Text('Add Lesson'),
            ),
          ],
        ),
      ),
    );
  }
}


