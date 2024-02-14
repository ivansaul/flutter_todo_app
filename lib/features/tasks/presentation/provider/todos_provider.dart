import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/features/tasks/data/todos_repository.dart';
import 'package:todo_app/features/tasks/domain/todo.dart';
import 'package:todo_app/features/tasks/presentation/provider/todos_repository_provider.dart';

enum TodoFilter { all, completed, pending, reminders }

final todoStatusFilterProvider = StateProvider<TodoFilter>((ref) {
  return TodoFilter.all;
});

final titleTodosStatusProvider = StateProvider<String>((ref) {
  final todoFilter = ref.watch(todoStatusFilterProvider);
  return switch (todoFilter) {
    TodoFilter.all => 'All',
    TodoFilter.completed => 'Completed',
    TodoFilter.pending => 'Pending',
    TodoFilter.reminders => 'Reminders',
  };
});

// ***********************************
// ***** FILTERED TODOS PROVIDER *****
// ***********************************

final filteredTodosProvider = Provider<List<Todo>>((ref) {
  final todoFilter = ref.watch(todoStatusFilterProvider);
  final todos = ref.watch(todosProvider);

  return switch (todoFilter) {
    TodoFilter.all => todos,
    TodoFilter.completed => todos.where((todo) => todo.completed).toList(),
    TodoFilter.pending => todos.where((todo) => !todo.completed).toList(),
    TodoFilter.reminders => <Todo>[],
  };
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
