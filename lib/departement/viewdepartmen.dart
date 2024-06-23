import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/const/link.dart'; // Replace with your link file

class ViewDepartmentPage extends StatefulWidget {
  @override
  _ViewDepartmentPageState createState() => _ViewDepartmentPageState();
}

class _ViewDepartmentPageState extends State<ViewDepartmentPage> {
  List departments = [];
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchDepartments();
  }

  fetchDepartments() async {
    try {
      final response = await http
          .get(Uri.parse(linkviewdep)); // Replace with correct endpoint

      if (response.statusCode == 200) {
        setState(() {
          departments = json.decode(response.body)['data'];
        });
      } else {
        setState(() {
          errorMessage = 'Failed to load departments (${response.statusCode})';
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to load departments (Exception: $e)';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Departments'),
      ),
      body: errorMessage.isNotEmpty
          ? Center(
              child: Text(
                errorMessage,
                style: TextStyle(fontSize: 18, color: Colors.red),
              ),
            )
          : departments.isEmpty
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: departments.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(departments[index]['departments_name']),
                        subtitle: Text(
                          'Department ID: ${departments[index]['departments_id']}',
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
