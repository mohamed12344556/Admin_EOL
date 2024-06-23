import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/const/link.dart';

class AddSubjectScreen extends StatefulWidget {
  @override
  _AddSubjectScreenState createState() => _AddSubjectScreenState();
}

class _AddSubjectScreenState extends State<AddSubjectScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _departmentIdController = TextEditingController();
  File? _image;
  final picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> _submitData() async {
    if (_nameController.text.isEmpty || _departmentIdController.text.isEmpty || _image == null) {
      // Display error
      return;
    }

    final request = http.MultipartRequest('POST', Uri.parse(linkaddsubject));
    request.fields['name'] = _nameController.text;
    request.fields['departmentid'] = _departmentIdController.text;
    request.files.add(await http.MultipartFile.fromPath('file', _image!.path));

    final response = await request.send();
    if (response.statusCode == 200) {
      print('Data submitted successfully');
    } else {
      print('Failed to submit data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Subject'),
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
              controller: _departmentIdController,
              decoration: const InputDecoration(labelText: 'Department ID'),
            ),
            const SizedBox(height: 10),
            _image == null
                ? const Text('No image selected.')
                : Image.file(_image!),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text('Pick Image'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _submitData,
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}


