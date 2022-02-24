import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/todos.dart';

class Input extends StatelessWidget {
  final controller = TextEditingController();

  Input({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todos = Provider.of<Todos>(context, listen: false);
    return Form(
      autovalidateMode: AutovalidateMode.always,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: 200,
            child: TextFormField(
              controller: controller,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Required';
                }
                return null;
              },
              //onSubmitted: todos.addTodo,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              var formState = GlobalKey<FormState>();

              if (formState == null) {
                throw 'no form';
              }

              if (formState.currentState != null &&
                  formState.currentState!.validate()) {
                todos.addTodo(controller.text);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
