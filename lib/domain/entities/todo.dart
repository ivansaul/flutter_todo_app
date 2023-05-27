// ***********************************
// ********* Todo Class **************
// ***********************************

// class Todo {
//   final String id;
//   String description;
//   bool completed;

//   Todo({
//     required this.id,
//     required this.description,
//     required this.completed,
//   });
// }

// ***********************************
// ***** Isar Implementation *********
// ***********************************

import 'package:isar/isar.dart';

part "todo.g.dart";

@collection
class Todo {
  Id isarId = Isar.autoIncrement;
  final String id;
  String description;
  bool completed;

  Todo({
    required this.id,
    required this.description,
    required this.completed,
  });
}
