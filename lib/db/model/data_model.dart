import 'package:hive/hive.dart';
part 'data_model.g.dart'; // Hive step 5 : Annotate the model class with @HiveType and provide a unique typeId

@HiveType(typeId: 1) // Hive step 2: Define a unique typeId for the model
class StudentModel {
  @HiveField(0)
  int? id; // Unique identifier for each student
  @HiveField(
    1,
  ) // Hive step 3: Annotate the fields with @HiveField and provide a unique index
  // Hive step 4: is a comand to generate the adapter for the model. Run the following command in the terminal:
  // "flutter packages pub run build_runner watch --delete-conflicting-outputs --use-polling-watcher"
  final String name;

  StudentModel({required this.name, this.id}); // Provide a default value for id
}
