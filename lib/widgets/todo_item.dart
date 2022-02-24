import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/todos.dart';

class TodoItem extends StatelessWidget {
  final String todo;
  final Widget leading;

  const TodoItem(this.todo, this.leading, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: GlobalKey(),
      onDismissed: (_) {
        var todos = Provider.of<Todos>(context, listen: false);
        todos
            .removeTodo(todo);
        print(todos.values);
      },
      background: Container(
        height: 80,
        width: double.infinity,
        color: Theme.of(context).colorScheme.primary,
      ),
      child: ListTile(
        title: Text(todo),
        leading: leading,
      ),
    );
  }
}
