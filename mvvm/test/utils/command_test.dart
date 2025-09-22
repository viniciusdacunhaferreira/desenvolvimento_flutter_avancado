import 'package:flutter_test/flutter_test.dart';
import 'package:mvvm/utils/command.dart';
import 'package:mvvm/utils/result.dart';

void main() {
  group('Should test Command0', () {
    test('Should test Command0 with Ok Result', () async {
      Future<Result<String>> okCommandAction0() async {
        await Future.delayed(const Duration(seconds: 1));
        return const Result.ok('Ok');
      }

      final command = Command0<String>(okCommandAction0);
      expect(command.completed, false);
      expect(command.error, false);
      expect(command.isRunning, false);
      expect(command.result, null);

      await command.execute();

      expect(command.completed, true);
      expect(command.error, false);
      expect(command.isRunning, false);
      expect(command.result, isA<Ok>());
      expect(command.result!.asOk.value, 'Ok');
    });
    test('Should test Command0 with Error Result', () async {
      Future<Result<bool>> errorCommandAction0() async {
        await Future.delayed(const Duration(seconds: 1));
        return Result.error(Exception('Error'));
      }

      final command = Command0<bool>(errorCommandAction0);
      expect(command.completed, false);
      expect(command.error, false);
      expect(command.isRunning, false);
      expect(command.result, null);

      await command.execute();

      expect(command.completed, false);
      expect(command.error, true);
      expect(command.isRunning, false);
      expect(command.result, isA<Error>());
      expect(command.result!.asError.error, isA<Exception>());
    });
  });
  group('Should test Command1', () {
    test('Should test Command1 with Ok Result', () async {
      Future<Result<String>> okCommandAction1(String param) async {
        await Future.delayed(const Duration(seconds: 1));
        return Result.ok(param);
      }

      final command = Command1<String, String>(okCommandAction1);
      expect(command.completed, false);
      expect(command.error, false);
      expect(command.isRunning, false);
      expect(command.result, null);

      await command.execute('Ok');

      expect(command.completed, true);
      expect(command.error, false);
      expect(command.isRunning, false);
      expect(command.result, isA<Ok>());
      expect(command.result!.asOk.value, 'Ok');
    });

    test('Should test Command0 with Error Result', () async {
      Future<Result<bool>> errorCommandAction1(String param) async {
        await Future.delayed(const Duration(seconds: 1));
        return Result.error(Exception(param));
      }

      final command = Command1<bool, String>(errorCommandAction1);
      expect(command.completed, false);
      expect(command.error, false);
      expect(command.isRunning, false);
      expect(command.result, null);

      await command.execute('Error');

      expect(command.completed, false);
      expect(command.error, true);
      expect(command.isRunning, false);
      expect(command.result, isA<Error>());
      expect(command.result!.asError.error, isA<Exception>());
    });
  });
}
