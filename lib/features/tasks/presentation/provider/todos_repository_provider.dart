import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/features/tasks/data/isar_repository.dart';
import 'package:todo_app/features/tasks/data/todos_repository.dart';

/// Provides an [IsarRepository] instance for managing local database operations.
final todosRepositoryProvider = Provider<TodosRepository>((ref) {
  return IsarRepository();
});
