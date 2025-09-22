import 'package:flutter/material.dart';

import '../../../domain/models/todo.dart';
import '../../../utils/result.dart';

abstract class TodosRepository extends ChangeNotifier {
  Future<Result<List<Todo>>> getTodos();

  Future<Result<void>> addTodo(Todo todo);

  Future<Result<void>> deleteTodo(String id);

  Future<Result<Todo>> getTodoById(String id);

  Future<Result<void>> updateTodo(Todo todo);
}
