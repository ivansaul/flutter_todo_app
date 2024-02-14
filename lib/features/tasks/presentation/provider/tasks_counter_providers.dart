import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/features/tasks/presentation/provider/todos_provider.dart';

final pendingCounterProvider = Provider<int>((ref) {
  final todos = ref.watch(todosProvider);
  final pending = todos.where((todo) => !todo.completed).toList();
  return pending.length;
});

final completedCounterProvider = Provider<int>((ref) {
  final todos = ref.watch(todosProvider);
  final completed = todos.where((todo) => todo.completed).toList();
  return completed.length;
});

final remindersCounterProvider = Provider<int>((ref) {
  return 0;
});
