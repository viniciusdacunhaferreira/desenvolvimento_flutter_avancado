import 'package:flutter/foundation.dart';

import 'result.dart';

typedef CommandAction0<T> = Future<Result<T>> Function();

typedef CommandAction1<T, A> = Future<Result<T>> Function(A);

typedef CommandAction2<T, A, B> = Future<Result<T>> Function(A, B);

typedef CommandAction3<T, A, B, C> = Future<Result<T>> Function(A, B, C);

abstract class Command<T> extends ChangeNotifier {
  bool _running = false;

  bool get isRunning => _running;

  Result<T>? _result;

  bool get error => _result is Error;

  bool get completed => _result is Ok;

  Result<T>? get result => _result;

  void clearResult() {
    _result = null;
    notifyListeners();
  }

  Future<void> _execute(CommandAction0<T> action) async {
    if (_running) return;

    _running = true;
    _result = null;
    notifyListeners();

    try {
      _result = await action.call();
    } finally {
      _running = false;
      notifyListeners();
    }
  }
}

final class Command0<T> extends Command {
  Command0(this._action);

  final CommandAction0<T> _action;

  Future<void> execute() async {
    await _execute(() => _action.call());
  }
}

final class Command1<T, A> extends Command {
  Command1(this._action);

  final CommandAction1<T, A> _action;

  Future<void> execute(A argument) async {
    await _execute(() => _action.call(argument));
  }
}

final class Command2<T, A, B> extends Command {
  Command2(this._action);

  final CommandAction2<T, A, B> _action;

  Future<void> execute(A argument1, B argument2) async {
    await _execute(() => _action.call(argument1, argument2));
  }
}

final class Command3<T, A, B, C> extends Command {
  Command3(this._action);

  final CommandAction3<T, A, B, C> _action;

  Future<void> execute(A argument1, B argument2, C argument3) async {
    await _execute(() => _action.call(argument1, argument2, argument3));
  }
}
