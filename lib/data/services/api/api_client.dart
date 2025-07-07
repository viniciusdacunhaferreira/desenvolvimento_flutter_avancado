import 'dart:convert';
import 'dart:io';

import '../../../utils/result.dart';
import 'models/todo/todo_api_model.dart';

class ApiClient {
  ApiClient({
    String? host,
    int? port,
    HttpClient Function()? httpClientFactory,
  })  : _host = host ?? 'localhost',
        _port = port ?? 3000,
        _httpClientFactory = httpClientFactory ?? HttpClient.new;

  final String _host;
  final int _port;
  final HttpClient Function() _httpClientFactory;

  Future<Result<List<TodoApiModel>>> getTodos() async {
    final client = _httpClientFactory();

    try {
      final request = await client
          .get(_host, _port, '/todos')
          .timeout(const Duration(seconds: 20));
      final response = await request.close();

      if (response.statusCode == 200) {
        final stringData = await response.transform(utf8.decoder).join();
        final json = jsonDecode(stringData) as List<dynamic>;
        final List<TodoApiModel> todos = json
            .map(
              (e) => TodoApiModel.fromJson(e),
            )
            .toList();

        return Result.ok(todos);
      } else {
        return const Result.error(HttpException('Invalide response'));
      }
    } on Exception catch (e) {
      return Result.error(e);
    } finally {
      client.close();
    }
  }

  Future<Result<TodoApiModel>> postTodo(TodoApiModel todo) async {
    final client = _httpClientFactory();
    try {
      final request = await client.post(_host, _port, '/todos');
      request.write(jsonEncode(todo.toJson()));
      final response = await request.close();
      if (response.statusCode == 201) {
        final stringData = await response.transform(utf8.decoder).join();
        final json = jsonDecode(stringData) as Map<String, Object?>;
        final createdTodo = TodoApiModel.fromJson(json);
        return Result.ok(createdTodo);
      } else {
        return const Result.error(HttpException('Invalid response'));
      }
    } on Exception catch (e) {
      return Result.error(e);
    } finally {
      client.close();
    }
  }

  Future<Result<void>> deleteTodo(String id) async {
    final client = _httpClientFactory();
    try {
      final request = await client.delete(_host, _port, '/todos/$id');
      final response = await request.close();
      if (response.statusCode == 200) {
        return const Result.ok(null);
      } else {
        return const Result.error(HttpException('Invalid response'));
      }
    } on Exception catch (e) {
      return Result.error(e);
    } finally {
      client.close();
    }
  }

  Future<Result<void>> putTodo(TodoApiModel todo) async {
    final client = _httpClientFactory();
    try {
      final request = await client.put(_host, _port, '/todos/${todo.id}');
      request.write(jsonEncode(todo.toJson()));
      final response = await request.close();
      if (response.statusCode == 200) {
        return const Result.ok(null);
      } else {
        return const Result.error(HttpException('Invalid response'));
      }
    } on Exception catch (e) {
      return Result.error(e);
    } finally {
      client.close();
    }
  }

  Future<Result<TodoApiModel>> getTodoById(String id) async {
    final client = _httpClientFactory();

    try {
      final request = await client.get(_host, _port, '/todos/$id');
      final response = await request.close();

      if (response.statusCode == 200) {
        final stringData = await response.transform(utf8.decoder).join();
        final json = jsonDecode(stringData) as Map<String, Object?>;
        final TodoApiModel todo = TodoApiModel.fromJson(json);

        return Result.ok(todo);
      } else {
        return const Result.error(HttpException('Invalide response'));
      }
    } on Exception catch (e) {
      return Result.error(e);
    } finally {
      client.close();
    }
  }
}
