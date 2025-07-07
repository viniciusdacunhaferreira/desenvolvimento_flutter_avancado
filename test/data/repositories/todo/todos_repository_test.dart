import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mvvm/data/repositories/todo/todos_repository_remote.dart';
import 'package:mvvm/data/services/api/api_client.dart';
import 'package:mvvm/data/services/api/models/todo/todo_api_model.dart';
import 'package:mvvm/domain/models/todo.dart';
import 'package:mvvm/utils/result.dart';

class MockApiClient extends Mock implements ApiClient {}

void main() {
  group('TodosRepository tests', () {
    late TodosRepositoryRemote todosRepository;
    late ApiClient apiClient;

    setUp(() {
      apiClient = MockApiClient();
      todosRepository = TodosRepositoryRemote(apiClient: apiClient);
    });

    test('should get todo', () async {
      const todoApiModel = TodoApiModel(title: 'Todo', id: 'aaaa', done: false);

      when(() => apiClient.getTodoById(any())).thenAnswer(
        (_) async => Future.value(const Result.ok(todoApiModel)),
      );

      final result = await todosRepository.getTodoById('');

      expect(result, isA<Ok<Todo>>());
    });
  });
}
