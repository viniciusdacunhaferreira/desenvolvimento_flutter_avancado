abstract class MyListenable {
  void addListener(void Function() listener);

  void removeListener(void Function() listener);
}

abstract class MyValueListenable<T> extends MyListenable {
  T get value;
}

class MyChangeNotifier implements MyListenable {
  final List<void Function()> _listeners = [];

  @override
  void addListener(void Function() listener) {
    _listeners.add(listener);
  }

  @override
  void removeListener(void Function() listener) {
    _listeners.remove(listener);
  }

  void notifyListeners() {
    for (void Function() listener in _listeners) {
      listener.call();
    }
  }
}

class MyValueNotifier<T> extends MyChangeNotifier implements MyValueListenable {
  MyValueNotifier(this._value);

  T _value;

  @override
  T get value => _value;

  set value(T newValue) {
    if (_value == newValue) return;

    _value = newValue;
    notifyListeners();
  }
}
