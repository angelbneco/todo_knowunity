import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_knowunity/models/todo_model.dart';
import 'package:http/http.dart' as http;

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  List<TodoModel> todos = [];
  TodoBloc() : super(const TodosInitial()) {
    on<LoadTodos>(_loadHome);
    on<TapCheckbox>(_tapCheckbox);
    on<AddTodo>(_addTodo);
  }

  void _loadHome(LoadTodos event, Emitter<TodoState> emitter) async {
    emitter(const TodosLoading());
    try {
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/todos'));

      if (response.statusCode == 200) {
        todos = (json.decode(response.body) as List)
            .map((data) => TodoModel.fromJson(data))
            .toList();
        emitter(TodosLoaded(todos: todos));
      } else {
        emitter(const TodosFailed());
      }
    } catch (e) {
      emitter(const TodosFailed());
    }
  }

  void _tapCheckbox(TapCheckbox event, Emitter<TodoState> emitter) async {
    emitter(const TodosLoading());
    int todoIndex = todos.indexWhere((element) => element.id == event.todoId);
    todos[todoIndex].completed = !todos[todoIndex].completed;
    emitter(TodosLoaded(todos: todos));
  }

  void _addTodo(AddTodo event, Emitter<TodoState> emitter) async {
    emitter(const TodosLoading());
    TodoModel newTodo = TodoModel(
        userId: 1,
        id: todos.length + 1,
        title: event.todoText,
        completed: false);
    todos.add(newTodo);
    emitter(TodosLoaded(todos: todos));
  }
}
