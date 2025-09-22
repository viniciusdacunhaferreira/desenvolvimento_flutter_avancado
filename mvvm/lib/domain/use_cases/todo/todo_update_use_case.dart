import 'package:logging/logging.dart';

import '../../../data/repositories/todo/todos_repository.dart';
import '../../../utils/result.dart';
import '../../models/todo.dart';

class TodoUpdateUseCase {
  TodoUpdateUseCase({
    required TodosRepository todosRepository,
  }) : _todosRepository = todosRepository;

  final TodosRepository _todosRepository;

  final _log = Logger('TodoUpdateUseCase');

  Future<Result<void>> updateTodo(Todo todo) async {
    try {
      final result = await _todosRepository.updateTodo(todo);

      switch (result) {
        case Ok<void>():
          _log.fine('Updated todo ${todo.id}');
          return const Result.ok(null);
        case Error<void>():
          _log.warning('Failed to add todo ${todo.id}');
          return Result.error(result.error);
      }
    } on Exception catch (e, s) {
      _log.warning('Exception to add todo', e, s);
      return Result.error(e);
    }
  }
}
