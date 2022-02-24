import 'package:flutter/foundation.dart';

class Todos with ChangeNotifier {
  final _values = [
    'flutter',
    'provider',
  ];

  List<String> get values {
    return [..._values];
  }

  void addTodo(String input) {
    _values.add(input);
    notifyListeners();
  }

  void removeTodo(String todo) {
    _values.remove(todo);
    notifyListeners();
  }
}
