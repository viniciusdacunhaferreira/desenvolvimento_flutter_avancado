import 'package:flutter/material.dart';

import '../../../domain/models/todo.dart';
import '../../../utils/result.dart';
import 'todos_repository.dart';

class TodosRepositoryDev extends ChangeNotifier implements TodosRepository {
  final List<Todo> _todos = [];

  @override
  Future<Result<void>> addTodo(Todo todo) async {
    _todos.add(todo);
    return const Result.ok(null);
  }

  @override
  Future<Result<void>> deleteTodo(String id) async {
    Todo? todoToDelete;
    for (Todo todo in _todos) {
      if (todo.id == id) todoToDelete = todo;
    }
    _todos.remove(todoToDelete);
    return const Result.ok(null);
  }

  @override
  Future<Result<List<Todo>>> getTodos() async {
    return Result.ok(List.from(_todos));
  }

  @override
  Future<Result<Todo>> getTodoById(String id) async {
    try {
      Todo? todoToGet;
      for (Todo todo in _todos) {
        if (todo.id == id) todoToGet = todo;
      }
      if (todoToGet != null) {
        return Result.ok(todoToGet);
      } else {
        return Result.error(Exception('Todo not found'));
      }
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<void>> updateTodo(Todo todo) async {
    try {
      final todoToUpdate = _todos.indexWhere((t) => t.id == todo.id);
      _todos[todoToUpdate] = todo;
      return const Result.ok(null);
    } on Exception catch (e) {
      return Result.error(e);
    } finally {
      notifyListeners();
    }
  }
}
