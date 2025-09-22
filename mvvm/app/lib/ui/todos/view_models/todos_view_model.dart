import 'dart:math';

import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

import '../../../data/repositories/todo/todos_repository.dart';
import '../../../domain/models/todo.dart';
import '../../../domain/use_cases/todo/todo_update_use_case.dart';
import '../../../utils/command.dart';
import '../../../utils/result.dart';

class TodosViewModel extends ChangeNotifier {
  TodosViewModel({
    required TodosRepository todoRepository,
    required TodoUpdateUseCase updateUseCase,
  })  : _todoRepository = todoRepository,
        _updateUseCase = updateUseCase {
    load = Command0(_load)..execute();
    refresh = Command0(_load);
    addTodo = Command2(_addTodo);
    deleteTodo = Command1(_deleteTodo);
    toggleTodo = Command1(_toggleTodo);
  }

  final TodoUpdateUseCase _updateUseCase;
  final TodosRepository _todoRepository;

  late Command0<List<Todo>> load;
  late Command0<List<Todo>> refresh;
  late Command2<void, String, String?> addTodo;
  late Command1<void, Todo> deleteTodo;
  late Command1<void, Todo> toggleTodo;

  List<Todo> _todos = [];

  List<Todo> get todos => _todos;

  final _log = Logger('TodosViewModel');

  Future<Result<List<Todo>>> _load() async {
    try {
      final result = await _todoRepository.getTodos();

      switch (result) {
        case Ok<List<Todo>>():
          _todos = result.value;
          notifyListeners();
          _log.fine('Loaded todos');
          break;
        case Error():
          _log.warning('Failed to load todos');
          break;
      }
      return result;
    } on Exception catch (e, s) {
      _log.warning('Failed to load todos', e, s);
      return Result.error(e);
    }
  }

  Future<Result<void>> _addTodo(
    String title,
    String? description,
  ) async {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    final random = Random();
    final id = List.generate(
      4,
      (index) => chars[random.nextInt(chars.length)],
    ).join();

    final Todo todo = Todo(
      id: id,
      title: title,
      done: false,
      description: description,
    );

    try {
      final result = await _todoRepository.addTodo(todo);

      switch (result) {
        case Ok<void>():
          _todos.add(todo);
          notifyListeners();
          _log.fine('Todo ${todo.id} added');
        case Error():
          _log.warning('Failed to add todo ${todo.id}');
          break;
      }
      return result;
    } on Exception catch (e, s) {
      _log.warning('Exception to add todo', e, s);
      return Result.error(e);
    }
  }

  Future<Result<void>> _deleteTodo(Todo todo) async {
    try {
      final result = await _todoRepository.deleteTodo(todo.id);

      switch (result) {
        case Ok<void>():
          _todos.remove(todo);
          notifyListeners();
          _log.fine('Todo ${todo.id} deleted');
        case Error():
          _log.warning('Failed to delete todo ${todo.id}');
      }

      return result;
    } on Exception catch (e, s) {
      _log.fine('Failed to delete todo', e, s);
      return Result.error(e);
    }
  }

  Future<Result<void>> _toggleTodo(Todo todo) async {
    final index = _todos.indexWhere((t) => t.id == todo.id);
    _todos[index] = todo.copyWith(done: !todo.done);
    notifyListeners();

    try {
      final result = await _updateUseCase.updateTodo(_todos[index]);

      switch (result) {
        case Ok<void>():
          _log.fine('Todo ${todo.id} done property changed to ${!todo.done}');
          return const Result.ok(null);
        case Error():
          _todos[index] = todo;
          notifyListeners();
          _log.warning('Failed to change todo ${todo.id} done status');
          return Result.error(result.error);
      }
    } on Exception catch (e) {
      _log.warning('Failed to change todo ${todo.id} done status');
      return Result.error(e);
    }
  }
}
