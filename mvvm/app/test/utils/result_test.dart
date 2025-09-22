import 'package:flutter_test/flutter_test.dart';
import 'package:mvvm/utils/result.dart';

void main() {
  group('Should test Ok Result', () {
    test('Should create a Ok Result with \'Ok\' value', () {
      const result = Result.ok('Ok');

      expect(result.asOk.value, 'Ok');
    });
    test('Should create a Ok Result with \'Ok\' value via extension', () {
      final result = 'Ok'.toOkResult();

      expect(result.asOk.value, 'Ok');
    });
  });

  group('Should test Error Result', () {
    test('Should create a Error Result with an Exception', () {
      final result = Result.error(Exception('Error'));

      expect(result.asError.error, isA<Exception>());
    });
    test('Should create a Error Result with an Exception via extension', () {
      final result = Exception('Error').toErrorResult();

      expect(result.asError.error, isA<Exception>());
    });
  });
}
