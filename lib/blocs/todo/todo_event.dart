part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();
}

class LoadTodos extends TodoEvent {
  const LoadTodos() : super();

  @override
  List<Object?> get props => [];
}

class TapCheckbox extends TodoEvent {
  const TapCheckbox({required this.todoId}) : super();

  final int todoId;

  @override
  List<Object?> get props => [];
}

class AddTodo extends TodoEvent {
  const AddTodo({required this.todoText}) : super();

  final String todoText;

  @override
  List<Object?> get props => [];
}
