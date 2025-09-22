import 'package:flutter/widgets.dart';

import '../../../data/repositories/todo/todos_repository.dart';
import '../../../domain/models/todo.dart';
import '../../../domain/use_cases/todo/todo_update_use_case.dart';
import '../../../utils/command.dart';
import '../../../utils/result.dart';

class TodoDetailsViewModel extends ChangeNotifier {
  TodoDetailsViewModel({
    required TodoUpdateUseCase updateTodoUseCase,
    required TodosRepository todosRepository,
  })  : _updateUseCase = updateTodoUseCase,
        _todosRepository = todosRepository {
    load = Command1(_load);
    updateTodo = Command1(_updateUseCase.updateTodo);

    _todosRepository.addListener(() {
      load.execute(_todo.id);
    });
  }

  final TodoUpdateUseCase _updateUseCase;
  final TodosRepository _todosRepository;

  late Command1<void, String> load;
  late Command1<void, Todo> updateTodo;
  late Todo _todo;

  Todo get todo => _todo;

  Future<Result<void>> _load(String id) async {
    try {
      final result = await _todosRepository.getTodoById(id);
      switch (result) {
        case Ok<Todo>():
          _todo = result.value;
          return const Result.ok(null);
        case Error<void>():
        // TODO: Implement logging
      }
      return result;
    } finally {
      notifyListeners();
    }
  }
}
