import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/features/tasks/data/todos_repository.dart';
import 'package:todo_app/features/tasks/domain/todo.dart';
import 'package:todo_app/features/tasks/presentation/provider/todos_repository_provider.dart';

enum TodoFilter { all, completed, pending, reminders }

/// The provider for managing the currently selected [TodoFilter].
final selectedFilterTodoProvider = StateProvider<TodoFilter>((ref) {
  return TodoFilter.all;
});

/// Provides a filtered list of [Todo] items based on the selected [TodoFilter].
final filteredTodosProvider = Provider<List<Todo>>((ref) {
  final todoFilter = ref.watch(selectedFilterTodoProvider);
  final todos = ref.watch(todosProvider);

  return switch (todoFilter) {
    TodoFilter.all => todos,
    TodoFilter.completed => todos.where((todo) => todo.completed).toList(),
    TodoFilter.pending => todos.where((todo) => !todo.completed).toList(),
    TodoFilter.reminders => <Todo>[],
  };
});

/// The provider for managing the list of [Todo] items.
final todosProvider = StateNotifierProvider<TodosNotifier, List<Todo>>((ref) {
  final todosRepository = ref.watch(todosRepositoryProvider);
  return TodosNotifier(todosRepository: todosRepository);
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

/// The provider for managing the new [Todo] description.
final newTodoProvider = StateProvider<String>((ref) {
  return '';
});
