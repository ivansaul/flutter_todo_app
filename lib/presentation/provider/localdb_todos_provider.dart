import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/todo.dart';
import '../../domain/usecases/localdb_usecase.dart';
import 'localdb_usecase_provider.dart';

enum TodoFilter { all, completed, pending }

final todoStatusFilterProvider = StateProvider<int>((ref) {
  return 0;
});

final titleTodosStatusProvider = StateProvider<String>((ref) {
  final todoFilter = ref.watch(todoStatusFilterProvider);
  switch (todoFilter) {
    case 0:
      return 'All';
    case 1:
      return 'Completed';
    case 2:
      return 'Pending';
    case 3:
      return 'Reminders';
  }
  return 'All';
});

final pendingcounterProvider = StateProvider<int>((ref) {
  final todos = ref.watch(todosProvider);
  final pending = todos.where((todo) => !todo.completed).toList();
  return pending.length;
});

final completedcounterProvider = StateProvider<int>((ref) {
  final todos = ref.watch(todosProvider);
  final completed = todos.where((todo) => todo.completed).toList();
  return completed.length;
});

final reminderscounterProvider = StateProvider<int>((ref) {
  return 0;
});

// ***********************************
// ***** FILTERED TODOS PROVIDER *****
// ***********************************

final filteredTodosProvider = Provider<List<Todo>>((ref) {
  final filter = ref.watch(todoStatusFilterProvider);
  final todos = ref.watch(todosProvider);

  switch (filter) {
    case 0:
      return todos;
    case 1:
      final completed = todos.where((todo) => todo.completed).toList();
      return completed;
    case 2:
      final pending = todos.where((todo) => !todo.completed).toList();
      return pending;
    case 3:
      final reminders = <Todo>[];
      return reminders;
  }
  return todos;
});

// // *****************************************
// // ***** NEWTODO DESCRIPTION PROVIDER ******
// // *****************************************

final dscNewTodoProvider = StateProvider<String>((ref) {
  return '';
});

// // **************************
// // ***** TODOS PROVIDER *****
// // **************************

final todosProvider = StateNotifierProvider<TodosNotifier, List<Todo>>((ref) {
  final localDbUsecase = ref.watch(localDbUsecaseProvider);
  return TodosNotifier(localDbUsecase: localDbUsecase);
});

class TodosNotifier extends StateNotifier<List<Todo>> {
  final LocalDbUsecase localDbUsecase;
  TodosNotifier({
    required this.localDbUsecase,
  }) : super([]);

  Future<void> addTodo({required String description}) async {
    await localDbUsecase.addTodo(description: description);
    state = await localDbUsecase.loadTodos();
  }

  Future<void> toggleTodo(String id) async {
    await localDbUsecase.toggleTodo(id);
    state = await localDbUsecase.loadTodos();
  }

  Future<void> deleteTodo(String id) async {
    await localDbUsecase.deleteTodo(id);
    state = await localDbUsecase.loadTodos();
  }

  Future<void> loadTodos() async {
    state = await localDbUsecase.loadTodos();
  }
}
