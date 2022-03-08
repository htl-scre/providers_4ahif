import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/todos.dart';

class TodoItem extends StatelessWidget {
  final String description;
  final String id;
  final bool done;

  const TodoItem(this.description, this.id, this.done, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var todos = Provider.of<Todos>(context, listen: false);
    return Dismissible(
      key: ValueKey(id),
      onDismissed: (_) {
        todos.removeTodo(id);
      },
      background: Container(
        height: 80,
        width: double.infinity,
        color: Theme.of(context).colorScheme.primary,
      ),
      child: ListTile(
        title: Text(description),
        leading: Icon(done ? Icons.check_circle_outline : Icons.circle),
        onTap: () => todos.toggleTodoDone(id),
      ),
    );
  }
}
