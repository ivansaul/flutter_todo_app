import 'package:todo_app/domain/repositories/localdb_repository.dart';
import 'package:todo_app/domain/usecases/localdb_usecase.dart';

import '../entities/todo.dart';

class LocalDbUsecaseImpl extends LocalDbUsecase {
  final LocalDbRepository localDbRepository;

  LocalDbUsecaseImpl(this.localDbRepository);

  @override
  Future<void> addTodo({required String description}) {
    return localDbRepository.addTodo(description: description);
  }

  @override
  Future<void> deleteTodo(String id) {
    return localDbRepository.deleteTodo(id);
  }

  @override
  Future<List<Todo>> loadTodos() {
    return localDbRepository.loadTodos();
  }

  @override
  Future<void> toggleTodo(String id) {
    return localDbRepository.toggleTodo(id);
  }
}
