import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_tutorial/db/model/data_model.dart';

ValueNotifier<List<StudentModel>> studentsListNotifier = ValueNotifier([]);

void addStudent(StudentModel value) {
  studentsListNotifier.value.add(value);
  studentsListNotifier.notifyListeners();
  log(value.name.toString());
}
