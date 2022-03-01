import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/todos.dart';

class Input extends StatefulWidget {

  Input({Key? key}) : super(key: key);

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  final controller = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final todos = Provider.of<Todos>(context, listen: false);
    return Form(
      key:formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
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
                if (value.length < 3) {
                  return 'Too short';
                }
                return null;
              },
              textInputAction: TextInputAction.,
              //onSubmitted: todos.addTodo,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              var formState = formKey.currentState;

              if (formState!.validate()) {
                todos.addTodo(controller.text);
                formState.reset();
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
