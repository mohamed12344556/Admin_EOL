import 'package:flutter/material.dart';
import 'package:untitled/subject/add.dart';
import 'package:untitled/subject/delete.dart';
import 'package:untitled/subject/update.dart';
import 'package:untitled/subject/viewsubject.dart';


class Subjectscreen extends StatelessWidget {
  const Subjectscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Subject",
          style: TextStyle(
            fontSize: 40,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.only(top: 90),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildButton("Add", Icons.add, () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AddSubjectScreen()));
              }),
              const SizedBox(width: 10),
              _buildButton("Delete", Icons.delete, () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => DeleteSubjectScreen()));
              }),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildButton("Update", Icons.update, () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => UpdateSubjectPage()));
              }),
              const SizedBox(width: 10),
              _buildButton("View", Icons.view_list, () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SubjectsPage()));
              }),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildButton(String text, IconData icon, VoidCallback onPressed) {
    return Center(
      child: Container(
        height: 70,
        width: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.blue,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 7,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: MaterialButton(
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white),
              const SizedBox(width: 10),
              Text(
                text,
                style: const TextStyle(fontSize: 20, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
