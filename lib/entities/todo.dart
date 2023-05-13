import 'package:hive/hive.dart';
part "todo.g.dart";

@HiveType(typeId: 1)
class Todo {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String description;
  @HiveField(2)
  final bool completed;

  Todo({
    required this.id,
    required this.description,
    required this.completed,
  });

  Todo copyWith({
    String? id,
    String? description,
    bool? completed,
    // String? title,
    // String? subtitle,
  }) =>
      Todo(
        id: id ?? this.id,
        description: description ?? this.description,
        completed: completed ?? this.completed,
      );
}
