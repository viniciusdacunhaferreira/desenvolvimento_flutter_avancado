import 'package:flutter_test/flutter_test.dart';
import 'package:mvvm/data/services/api/api_client.dart';
import 'package:mvvm/data/services/api/models/todo/todo_api_model.dart';
import 'package:mvvm/utils/result.dart';

void main() {
  late ApiClient apiClient;

  setUp(() {
    apiClient = ApiClient();
  });

  group('Should test [ApiClient]', () {
    test('Should return Result Ok when getTodos()', () async {
      final result = await apiClient.getTodos();

      expect(result.asOk.value, isA<List<TodoApiModel>>());
    });

    test('Should return Result Ok when postTodos()', () async {
      const todo = TodoApiModel(id: 'post', title: 'Test todo', done: false);

      final result = await apiClient.postTodo(todo);

      expect(result.asOk.value, isA<TodoApiModel>());
    });

    test('Should return Result Ok when deleteTodo()', () async {
      const todo = TodoApiModel(id: 'delete', title: 'Test todo', done: false);

      final postResult = await apiClient.postTodo(todo);

      expect(postResult.asOk.value, isA<TodoApiModel>());

      await apiClient.deleteTodo(todo.id);

      final todosResult = await apiClient.getTodos();
      final todos = todosResult.asOk.value;

      expect(todos, isNot(contains(todo)));
    });
    test('Should return Result Ok when putTodo()', () async {
      const todo = TodoApiModel(id: 'put', title: 'Put test todo', done: false);

      final postResult = await apiClient.postTodo(todo);

      expect(postResult.asOk.value, isA<TodoApiModel>());

      const putTodo = TodoApiModel(
        id: 'put',
        title: 'Put test todo OK',
        done: false,
      );
      await apiClient.putTodo(putTodo);

      final todosResult = await apiClient.getTodos();
      final todos = todosResult.asOk.value;

      expect(todos, isNot(contains(todo)));
    });
    test('Should return Result Ok when getTodoById()', () async {
      const todo =
          TodoApiModel(id: 'getTodoById', title: 'Todo to get', done: false);

      final postResult = await apiClient.postTodo(todo);

      expect(postResult.asOk.value, isA<TodoApiModel>());

      final result = await apiClient.getTodoById(todo.id);

      expect(result, isA<Result<TodoApiModel>>());
    });
  });
}
