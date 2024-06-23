import 'package:flutter/material.dart';
import 'package:untitled/Lessons/addlessons.dart';
import 'package:untitled/Lessons/deletelessons.dart';
import 'package:untitled/Lessons/updatelessons.dart';
import 'package:untitled/Lessons/viewlessons.dart';


class Lessonscreen extends StatelessWidget {
  const Lessonscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Lessons",
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
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AddLessonPage()));
              }),
              const SizedBox(width: 10),
              _buildButton("Delete", Icons.delete, () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => DeleteLessonPage()));
              }),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildButton("Update", Icons.update, () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => UpdateLessonPage()));
              }),
              const SizedBox(width: 10),
              _buildButton("View", Icons.view_list, () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ViewLessonsPage()));
              }),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildButton(String text, IconData icon, VoidCallback onPressed) {
    return Container(
      height: 70,
      width: 150,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(30),
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
    );
  }
}
