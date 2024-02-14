import 'package:hive_flutter/adapters.dart';
import 'package:todo_app/features/tasks/data/todos_repository.dart';
import 'package:todo_app/features/tasks/domain/todo.dart';
import 'package:uuid/uuid.dart';

class HiveRepository extends TodosRepository {
  late Future<Box<Todo>> db;

  HiveRepository() {
    db = openDB();
  }

  Future<Box<Todo>> openDB() async {
    Hive.registerAdapter(TodoAdapter());
    await Hive.initFlutter();
    var box = await Hive.openBox<Todo>('todoBox');
    return box;
  }

  @override
  Future<void> addTodo({required String description}) async {
    final box = await db;
    const uuid = Uuid();
    final newTodo =
        Todo(id: uuid.v4(), description: description, completed: false);
    await box.put(newTodo.id, newTodo);
  }

  @override
  Future<void> deleteTodo(String id) async {
    final box = await db;
    final todo = box.values.firstWhere((todo) => todo.id == id);
    await box.delete(todo.id);
  }

  @override
  Future<List<Todo>> getTodos() async {
    final box = await db;
    final todos = box.values.toList();
    return todos;
  }

  @override
  Future<void> toggleTodo(String id) async {
    final box = await db;
    final todo = box.values.firstWhere((todo) => todo.id == id);
    await box.put(todo.id, todo..completed = !todo.completed);
  }
}
