import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/const/link.dart'; // Adjust import as per your project structure

class ViewUnits extends StatefulWidget {
  @override
  _ViewUnitsState createState() => _ViewUnitsState();
}

class _ViewUnitsState extends State<ViewUnits> {
  List<Map<String, dynamic>> units = []; // Define units as a list of maps

  @override
  void initState() {
    super.initState();
    fetchUnits();
  }

  fetchUnits() async {
    final response = await http.get(Uri.parse(linkviewunits));

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);

      if (jsonResponse['status'] == 'success') {
        setState(() {
          units = List<Map<String, dynamic>>.from(jsonResponse['data']);
        });
      } else {
        throw Exception('Failed to load units');
      }
    } else {
      throw Exception('Failed to load units');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Units'),
      ),
      body: units.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: units.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(units[index]['units_name']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Units ID: ${units[index]['units_id']}'),
                        SizedBox(height: 2),
                        Text(
                            'Units of Subject: ${units[index]['units_subjects']}'),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
