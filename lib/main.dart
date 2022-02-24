import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/home_page.dart';
import 'providers/todos.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return Todos();
      },
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.purple,
            accentColor: Colors.lime,
          ),
          textTheme: const TextTheme(
            button: TextStyle(
              fontFamily: 'JetBrainsMono',
            ),
            headline6: TextStyle(
              fontFamily: 'JetBrainsMono',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        home: HomePage(),
      ),
    );
  }
}
