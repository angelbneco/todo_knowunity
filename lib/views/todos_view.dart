import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_knowunity/blocs/todo/todo_bloc.dart';
import 'package:todo_knowunity/utils/general_utils.dart';

class TodosView extends StatefulWidget {
  const TodosView({super.key});

  @override
  State<TodosView> createState() => _TodosViewState();
}

class _TodosViewState extends State<TodosView> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<TodoBloc>(context).add(const LoadTodos());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List - Knowunity'),
      ),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state is TodosLoaded) {
            return ListView.builder(
              itemCount: state.todos.length,
              itemBuilder: (BuildContext context, int index) {
                return Visibility(
                  visible: state.todos[index].userId == 1,
                  child: ListTile(
                    leading: IconButton(
                      icon: Icon(
                        state.todos[index].completed
                            ? Icons.check_box
                            : Icons.check_box_outline_blank,
                        color: state.todos[index].completed
                            ? Colors.blue
                            : Colors.grey,
                      ),
                      onPressed: () => BlocProvider.of<TodoBloc>(context).add(
                        TapCheckbox(todoId: state.todos[index].id),
                      ),
                    ),
                    title: Text(state.todos[index].title),
                  ),
                );
              },
            );
          } else if (state is TodosLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return const Center(
              child: Text('Something went wrong. Try restarting the app.'),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => addTodo(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void addTodo(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String todoText = '';
        return AlertDialog(
          title: const Text('Add Todo'),
          content: TextField(
            onChanged: (value) {
              todoText = value;
            },
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                if (todoText.isNotEmpty) {
                  BlocProvider.of<TodoBloc>(context)
                      .add(AddTodo(todoText: todoText));
                  Navigator.of(context).pop();
                } else {
                  showToastMessage("Todo entry can't be empty.");
                }
              },
            ),
          ],
        );
      },
    );
  }
}
