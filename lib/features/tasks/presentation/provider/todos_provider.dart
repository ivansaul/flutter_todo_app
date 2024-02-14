import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/features/tasks/data/todos_repository.dart';
import 'package:todo_app/features/tasks/domain/todo.dart';
import 'package:todo_app/features/tasks/presentation/provider/todos_repository_provider.dart';

enum TodoFilter { all, completed, pending, reminders }

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
  final isarRepository = ref.watch(todosRepositoryProvider);
  return TodosNotifier(todosRepository: isarRepository);
});

class TodosNotifier extends StateNotifier<List<Todo>> {
  final TodosRepository todosRepository;
  TodosNotifier({
    required this.todosRepository,
  }) : super([]);

  Future<void> addTodo({required String description}) async {
    await todosRepository.addTodo(description: description);
    state = await todosRepository.getTodos();
  }

  Future<void> toggleTodo(String id) async {
    await todosRepository.toggleTodo(id);
    state = await todosRepository.getTodos();
  }

  Future<void> deleteTodo(String id) async {
    await todosRepository.deleteTodo(id);
    state = await todosRepository.getTodos();
  }

  Future<void> loadTodos() async {
    state = await todosRepository.getTodos();
  }
}
