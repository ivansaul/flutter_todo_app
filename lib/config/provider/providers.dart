import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/entities/todo.dart';
import 'package:uuid/uuid.dart';

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

// **************************
// ***** TODOS PROVIDER *****
// **************************

const _uuid = Uuid();
final _todosBox = Hive.box<Todo>('allTodosBox');

final todosProvider = StateNotifierProvider<TodosNotifier, List<Todo>>((ref) {
  final todos = _todosBox.values.isEmpty ? <Todo>[] : _todosBox.values.toList();
  return TodosNotifier(todos.reversed.toList());
});

class TodosNotifier extends StateNotifier<List<Todo>> {
  TodosNotifier(List<Todo> todos) : super(todos);

  void addTodo({required String description}) {
    final Todo newtodo = Todo(
      id: _uuid.v4(),
      description: description,
      completed: false,
    );
    state = [newtodo, ...state];
    _todosBox.put(newtodo.id, newtodo);
  }

  void toggleTodo(String id) {
    state = state.map((todo) {
      if (todo.id != id) return todo;
      return todo.copyWith(completed: !todo.completed);
    }).toList();
    _todosBox.clear();
    _todosBox.addAll(state);
  }

  void deleteTodo(String id) {
    state = state.where((todo) => todo.id != id).toList();
    _todosBox.delete(id);
  }
}

// *****************************************
// ***** NEWTODO DESCRIPTION PROVIDER ******
// *****************************************

final dscNewTodoProvider = StateProvider<String>((ref) {
  return '';
});
