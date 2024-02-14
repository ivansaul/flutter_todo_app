import 'package:todo_app/features/tasks/domain/todo.dart';

/// A repository interface defining the operations for managing [Todo] items.
abstract class TodosRepository {
  Future<List<Todo>> getTodos();
  Future<void> deleteTodo(String id);
  Future<void> addTodo({required String description});
  Future<void> toggleTodo(String id);
}
