import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_tutorial/db/model/data_model.dart';

ValueNotifier<List<StudentModel>> studentsListNotifier = ValueNotifier([]);

Future<void> addStudent(StudentModel value) async {
  final studentDB = await Hive.openBox<StudentModel>(
    'student_db',
  ); // step 7: Open the Hive box before performing any operations
  final _id = await studentDB.add(
    value,
  ); // step 8: Add the student to the Hive box
  value.id =
      _id; // Assign the generated key to the id field of the student model

  studentsListNotifier.value.add(value);
  studentsListNotifier.notifyListeners();
  log(value.name.toString());
}

Future<void> getAllStudents() async {
  final studentDB = await Hive.openBox<StudentModel>(
    'student_db',
  ); // step 7: Open the Hive box before performing any operations
  studentsListNotifier.value
      .clear(); // Clear the existing list before adding new values
  studentsListNotifier.value.addAll(
    studentDB.values,
  ); // step 9: Retrieve all students from the Hive box and update the ValueNotifier
  studentsListNotifier.notifyListeners(); // Notify listeners to update the UI
}

Future<void> deleteStudent(int id) async {
  final studentDB = await Hive.openBox<StudentModel>(
    'student_db',
  ); // step 7: Open the Hive box before performing any operations
  await studentDB.delete(
    id,
  ); // step 10: Delete the student from the Hive box using the provided id
  getAllStudents(); // Refresh the list of students after deletion
}

Future<void> updateStudent(int id, StudentModel value) async {
  final studentDB = await Hive.openBox<StudentModel>(
    'student_db',
  ); // step 7: Open the Hive box before performing any operations
  await studentDB.put(
    id,
    value,
  ); // step 11: Update the student in the Hive box using the provided id and new value
  getAllStudents(); // Refresh the list of students after updating
}
