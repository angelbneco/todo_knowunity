import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_knowunity/blocs/todo/todo_bloc.dart';
import 'package:todo_knowunity/views/todos_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => TodoBloc()),
      ],
      child: MaterialApp(
        title: 'Todo List - Knowunity',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const TodosView(),
      ),
    );
  }
}
