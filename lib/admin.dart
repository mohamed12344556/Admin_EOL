import 'package:flutter/material.dart';
import 'package:untitled/Lessons/lessons.dart';
import 'package:untitled/Quizes/quizes.dart';
import 'package:untitled/subject/subject.dart';
import 'package:untitled/unit/units.dart';

import 'departement/department.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 2, 79, 141),
      appBar: AppBar(
        title: const Text(
          "Admin",
          style: TextStyle(fontSize: 40, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 2, 79, 141),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.only(top: 90),
        children: [
          Row(
            children: [
              _buildButton("Subject ", () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: ((context) => const Subjectscreen())));
              }),
              const SizedBox(width: 5),
              _buildButton("department", () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: ((context) => const Departmentscreen())));
              }),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              _buildButton("quiz", () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: ((context) => const Quizscreen())));
              }),
              const SizedBox(width: 5),
              _buildButton("Lessons", () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: ((context) => const Lessonscreen())));
              }),
            ],
          ),
          const SizedBox(height: 10),
          _buildButton("Units", () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: ((context) => const Unitscreen())));
          }),
        ],
      ),
    );
  }

  Widget _buildButton(String text, VoidCallback onPressed) {
    return Center(
      child: Container(
        height: 70,
        width: 220, // Adjusted width to a smaller value
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
          child: Text(
            text,
            style: const TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
