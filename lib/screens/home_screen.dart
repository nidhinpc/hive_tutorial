import 'package:flutter/material.dart';
import 'package:hive_tutorial/db/functions/db_functions.dart';
import 'package:hive_tutorial/db/model/data_model.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Screen')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'Enter name',
              border: OutlineInputBorder(),
            ),
          ),

          // add button
          ElevatedButton(
            onPressed: () {
              onAddStudentButtonClickked();
            }, // Add your onPressed logic here
            child: Text('Submit'),
          ),

          //show list  added names
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: studentsListNotifier,
              builder: (context, studentsList, child) {
                return ListView.builder(
                  itemCount: studentsList.length,
                  itemBuilder: (context, index) {
                    final student = studentsList[index];
                    return ListTile(
                      title: Text(student.name), // Replace with actual name
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> onAddStudentButtonClickked() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      return;
      // Add the name to your list or perform any other action
    }
    //print('Name added: $name');

    StudentModel student = StudentModel(name: name);
    addStudent(student);
  }
}
