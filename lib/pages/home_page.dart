import 'package:flutter/material.dart';
import 'package:list/widgets/todo_item.dart';
import 'package:provider/provider.dart';

import '../providers/todos.dart';
import '../widgets/input.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future _futureTodos;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Todos',
          ),
          backgroundColor:
              MediaQuery.of(context).orientation == Orientation.portrait
                  ? Theme.of(context).colorScheme.secondary
                  : Colors.red),
      body: Column(
        children: [
          Input(),
          Expanded(
            child: FutureBuilder(
              future: _futureTodos,
              builder: (_, snapshot) {
                return snapshot.connectionState == ConnectionState.waiting
                    ? Center(child: CircularProgressIndicator())
                    : buildTodoList();
              },
            ),
          ),
        ],
      ),
    );
  }

  // wird nur EINMAL ausgeführt, idealer Ort um die todos EINMAL zu laden
  @override
  void initState() {
    _futureTodos = Provider.of<Todos>(context, listen: false).loadTodos();
  }

  buildTodoList() {
    final todos = Provider.of<Todos>(context).all;
    return ListView.builder(
      itemBuilder: (_, index) => TodoItem(
        todos[index].description,
        todos[index].id!,
        todos[index].done,
      ),
      itemCount: todos.length,
    );
  }
}
