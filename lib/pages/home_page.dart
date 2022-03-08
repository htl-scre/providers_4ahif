import 'package:flutter/material.dart';
import 'package:list/widgets/todo_item.dart';
import 'package:provider/provider.dart';

import '../providers/todos.dart';
import '../widgets/input.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todos = Provider.of<Todos>(context, listen: true);
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
            child: ListView.builder(
              itemBuilder: (_, index) =>
                  TodoItem(todos.all[index].description, todos.all[index].id, todos.all[index].done),
              itemCount: todos.all.length,
            ),
          ),
        ],
      ),
    );
  }
}
