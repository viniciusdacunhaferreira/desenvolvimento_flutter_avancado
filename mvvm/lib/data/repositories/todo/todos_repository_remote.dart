import 'package:flutter/widgets.dart';

import '../../../domain/models/todo.dart';
import '../../../utils/result.dart';
import '../../services/api/api_client.dart';
import '../../services/api/models/todo/todo_api_model.dart';
import 'todos_repository.dart';

class TodosRepositoryRemote extends ChangeNotifier implements TodosRepository {
  TodosRepositoryRemote({required ApiClient apiClient})
      : _apiClient = apiClient;

  final ApiClient _apiClient;

  List<Todo> _cachedTodos = [];

  @override
  Future<Result<void>> addTodo(Todo todo) async {
    try {
      final todoApiModel = TodoApiModel(
        title: todo.title,
        id: todo.id,
        done: todo.done,
        description: todo.description,
      );
      final result = await _apiClient.postTodo(todoApiModel);
      switch (result) {
        case Ok<void>():
          // _todos.add(todo);
          return const Result.ok(null);
        case Error():
          return Result.error(result.error);
      }
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<void>> deleteTodo(String id) async {
    try {
      final result = await _apiClient.deleteTodo(id);
      switch (result) {
        case Ok<void>():
          _cachedTodos.removeWhere((todo) => todo.id == id);
          return const Result.ok(null);
        case Error():
          return Result.error(result.error);
      }
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<List<Todo>>> getTodos() async {
    try {
      final result = await _apiClient.getTodos();
      switch (result) {
        case Ok<List<TodoApiModel>>():
          final todos = result.value
              .map(
                (todoApi) => Todo(
                  id: todoApi.id,
                  title: todoApi.title,
                  done: todoApi.done,
                  description: todoApi.description,
                ),
              )
              .toList();
          _cachedTodos = todos;
          return Result.ok(todos);
        case Error<List<TodoApiModel>>():
          return Result.error(result.error);
      }
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<Todo>> getTodoById(String id) async {
    for (Todo todo in _cachedTodos) {
      if (todo.id == id) {
        return Result.ok(todo);
      }
    }

    try {
      final result = await _apiClient.getTodoById(id);
      switch (result) {
        case Ok<TodoApiModel>():
          final todoApi = result.value;
          final todo = Todo(
            id: todoApi.id,
            title: todoApi.title,
            done: todoApi.done,
            description: todoApi.description,
          );
          return Result.ok(todo);
        case Error<TodoApiModel>():
          return Result.error(result.error);
      }
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<void>> updateTodo(Todo todo) async {
    final todoApiModel = TodoApiModel(
      id: todo.id,
      title: todo.title,
      description: todo.description,
      done: todo.done,
    );
    try {
      final result = await _apiClient.putTodo(todoApiModel);
      switch (result) {
        case Ok<void>():
          final todoToUpdate = _cachedTodos.indexWhere((t) => t.id == todo.id);
          _cachedTodos[todoToUpdate] = todo;
          return const Result.ok(null);
        case Error<void>():
          return Result.error(result.error);
      }
    } on Exception catch (e) {
      return Result.error(e);
    } finally {
      notifyListeners();
    }
  }
}
