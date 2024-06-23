import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

import 'package:untitled/const/link.dart';

class UpdateSubjectPage extends StatefulWidget {
  @override
  _UpdateSubjectPageState createState() => _UpdateSubjectPageState();
}

class _UpdateSubjectPageState extends State<UpdateSubjectPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _departmentController = TextEditingController();
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _updateSubject() async {
    final uri = Uri.parse(linkupdatesubject);
    var request = http.MultipartRequest('POST', uri)
      ..fields['id'] = '1' // Replace with actual ID
      ..fields['name'] = _nameController.text
      ..fields['departmentid'] = _departmentController.text
      ..fields['imageold'] = 'old_image.jpg'; // Replace with actual old image name

    if (_image != null) {
      request.files.add(await http.MultipartFile.fromPath('file', _image!.path));
    }

    var response = await request.send();
    if (response.statusCode == 200) {
      print('Subject updated successfully');
    } else {
      print('Failed to update subject');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Subject'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Subject Name'),
            ),
            TextField(
              controller: _departmentController,
              decoration: const InputDecoration(labelText: 'Department ID'),
            ),
            const SizedBox(height: 20),
            _image == null
                ? const Text('No image selected.')
                : Image.file(_image!),
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text('Pick Image'),
            ),
            const SizedBox(height: 5,),
            ElevatedButton(
              onPressed: _updateSubject,
              child: const Text('Update Subject'),
            ),
          ],
        ),
      ),
    );
  }
}
