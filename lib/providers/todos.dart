import 'package:flutter/foundation.dart';
import 'package:list/domain/todo.dart';

class Todos with ChangeNotifier {
  var _values = <Todo>[];
  var initialized = false;

  List<Todo> get all {
    if (!initialized) {
      getTodos();
      initialized = true;
    }
    return [..._values];
  }

  void getTodos() {
    _values = [
      Todo(description: 'flutter'),
      Todo(description: 'provider'),
    ];
  }

  void addTodo(String description) {
    _values.add(Todo(description: description));
    notifyListeners();
  }

  void removeTodo(String id) {
    _values.removeWhere((todo) => todo.id == id);
    notifyListeners();
  }

  void toggleTodoDone(String id) {
    final todo = _values.where((todo) => todo.id == id).single;
    todo.done = !todo.done;
    notifyListeners();
  }
}
