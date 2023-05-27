import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

import '../../domain/entities/todo.dart';
import '../../domain/repositories/localdb_repository.dart';

class LocalDbRepositoryIsarImpl extends LocalDbRepository {
  late Future<Isar> db;

  LocalDbRepositoryIsarImpl() {
    db = openDB();
  }

  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();
      final isar = await Isar.open([TodoSchema], directory: dir.path);
      return isar;
    }
    return Future.value(Isar.getInstance());
  }

  @override
  Future<void> addTodo({required String description}) async {
    final Isar isar = await db;
    const uuid = Uuid();
    await isar.writeTxn(() async {
      final newTodo = Todo(id: uuid.v4(), description: description, completed: false);
      await isar.todos.put(newTodo);
    });
  }

  @override
  Future<void> deleteTodo(String id) async {
    final Isar isar = await db;
    final Todo? todo = await isar.todos.filter().idEqualTo(id).findFirst();
    if (todo != null) {
      await isar.writeTxn(() async {
        await isar.todos.delete(todo.isarId);
      });
    }
  }

  @override
  Future<void> toggleTodo(String id) async {
    final Isar isar = await db;
    await isar.writeTxn(() async {
      final Todo? todo = await isar.todos.filter().idEqualTo(id).findFirst();

      if (todo != null) {
        todo.completed = !todo.completed;
        await isar.todos.put(todo);
      }
    });
  }

  @override
  Future<List<Todo>> loadTodos() async {
    final Isar isar = await db;
    final todos = await isar.todos.where(sort: Sort.desc).anyIsarId().findAll();
    return todos;
  }
}
