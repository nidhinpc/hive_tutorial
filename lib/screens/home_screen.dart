import 'package:flutter/material.dart';
import 'package:hive_tutorial/db/functions/db_functions.dart';
import 'package:hive_tutorial/db/model/data_model.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    getAllStudents(); // Fetch all students when the screen is built
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
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              // Implement your edit functionality here
                              // For example, you can show a dialog to edit the student's name
                              showDialog(
                                context: context,
                                builder: (context) {
                                  final TextEditingController
                                  _editNameController = TextEditingController(
                                    text: student.name,
                                  );
                                  return AlertDialog(
                                    title: Text('Edit Student Name'),
                                    content: TextField(
                                      controller: _editNameController,
                                      decoration: InputDecoration(
                                        labelText: 'Enter new name',
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(
                                            context,
                                          ).pop(); // Close the dialog
                                        },
                                        child: Text('Cancel'),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          if (student.id == null) {
                                            // Handle the case where the id is null (optional)
                                            print(
                                              'Student ID is null. Cannot update.',
                                            );
                                            return;
                                          }
                                          final newName = _editNameController
                                              .text
                                              .trim();
                                          if (newName.isNotEmpty) {
                                            StudentModel updatedStudent =
                                                StudentModel(
                                                  id: student.id,
                                                  name: newName,
                                                );
                                            updateStudent(
                                              student.id!,
                                              updatedStudent,
                                            );
                                            Navigator.of(
                                              context,
                                            ).pop(); // Close the dialog
                                          }
                                        },
                                        child: Text('Update'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                          SizedBox(
                            width: 8,
                          ), // Add some spacing between the buttons
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              print("Student Name: ${student.name}");
                              print("Student ID: ${student.id}");

                              if (student.id == null) {
                                print("ID is NULL");
                                return;
                              }

                              deleteStudent(student.id!);
                            },
                          ),
                        ],
                      ),
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
