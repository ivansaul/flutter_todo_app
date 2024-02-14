import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/features/tasks/data/hive_repository.dart';
import 'package:todo_app/features/tasks/data/todos_repository.dart';

/// Provides an [HiveRepository] instance for managing local database operations.
final todosRepositoryProvider = Provider<TodosRepository>((ref) {
  return HiveRepository();
});
