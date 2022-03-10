import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:list/domain/todo.dart';

class Todos with ChangeNotifier {
  var _values = <Todo>[];
  static const baseUrl =
      'https://ahif-todos-default-rtdb.europe-west1.firebasedatabase.app';

  List<Todo> get all {
    return [..._values];
  }

  Future<void> loadTodos() async {
    final url = Uri.parse('$baseUrl/todos.json');
    try {
      final response = await http.get(url);
      final data = jsonDecode(response.body);
      _values = data.entries
          .map<Todo>((entry) => Todo.fromJson(entry.value, entry.key))
          .toList();
    } catch (error) {
      print(error);
      // rethrow und im GUI error handeln
    }
  }

  Future<void> addTodo(String description) async {
    final url = Uri.parse('$baseUrl/todos.json');
    final todo = Todo(description: description);
    final body = jsonEncode(todo.toJson());
    try {
      final response = await http.post(url, body: body);
      todo.id = jsonDecode(
          response.body)['name']; // Firebase returnt bei POST immer name
      _values.add(todo);
      notifyListeners();
    } catch (error) {
      print(error);
      // rethrow und im GUI error handeln;
    }
  }

  void removeTodo(String id) {
    _values.removeWhere((todo) => todo.id == id);
    notifyListeners();
  }

  // optimistic updating
  Future<void> toggleTodoDone(String id) async {
    final url = Uri.parse('$baseUrl/todos/$id.json');
    final todo = _values.where((todo) => todo.id == id).single;
    final old = todo.done;
    todo.done = !old;
    notifyListeners();
    try {
      final body = jsonEncode(todo.toJson());
      final response = await http.put(url, body: body);
      var successful = response.statusCode < 400;
      if (!successful) {
        restoreDone(todo, old);
      }
    } catch (error) {
      restoreDone(todo, old);
      rethrow;
    }
  }

  void restoreDone(Todo todo, bool old) {
    todo.done = old;
    notifyListeners();
  }
}
