import 'package:hive_flutter/adapters.dart';
import 'package:todo_app/domain/repositories/localdb_repository.dart';
import 'package:uuid/uuid.dart';

import '../../domain/entities/todo.dart';

class LocalDbRepositoryHiveImpl extends LocalDbRepository {
  late Future<Box<Todo>> db;

  LocalDbRepositoryHiveImpl() {
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
    final newTodo = Todo(id: uuid.v4(), description: description, completed: false);
    await box.put(newTodo.id, newTodo);
  }

  @override
  Future<void> deleteTodo(String id) async {
    final box = await db;
    final todo = box.values.firstWhere((todo) => todo.id == id);
    await box.delete(todo.id);
  }

  @override
  Future<List<Todo>> loadTodos() async {
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
