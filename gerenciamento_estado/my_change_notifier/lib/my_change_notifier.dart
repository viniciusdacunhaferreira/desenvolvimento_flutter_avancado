abstract class MyListenable {
  void addListener(void Function() listener);

  void removeListener(void Function() listener);
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
