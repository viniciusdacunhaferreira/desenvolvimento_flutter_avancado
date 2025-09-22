import 'package:flutter_test/flutter_test.dart';
import 'package:mvvm/data/repositories/todo/todos_repository.dart';
import 'package:mvvm/data/repositories/todo/todos_repository_dev.dart';
import 'package:mvvm/domain/use_cases/todo/todo_update_use_case.dart';
import 'package:mvvm/ui/todos/view_models/todos_view_model.dart';

void main() {
  late TodosViewModel todoViewModel;
  late TodosRepository todoRepository;
  late TodoUpdateUseCase todoUpdateUseCase;

  setUp(() {
    todoRepository = TodosRepositoryDev();
    todoUpdateUseCase = TodoUpdateUseCase(todosRepository: todoRepository);
    todoViewModel = TodosViewModel(
      todoRepository: todoRepository,
      updateUseCase: todoUpdateUseCase,
    );
  });

  group('Should test TodoViewModel', () {
    test('Verify if TodoViewModel has no Todo when instantiated', () {
      expect(todoViewModel.todos, isEmpty);
    });
    test('Should add Todo', () async {
      await todoViewModel.addTodo.execute('New todo', null);

      expect(todoViewModel.todos.first.title, 'New todo');
    });
    test('Should delete Todo', () async {
      await todoViewModel.addTodo.execute('New todo', null);

      expect(todoViewModel.todos.first.title, 'New todo');

      await todoViewModel.deleteTodo.execute(todoViewModel.todos.first);

      expect(todoViewModel.todos, isEmpty);
    });
  });
}
