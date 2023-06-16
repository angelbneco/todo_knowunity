part of 'todo_bloc.dart';

abstract class TodoState extends Equatable {
  const TodoState();
}

class TodosInitial extends TodoState {
  const TodosInitial();

  @override
  List<Object?> get props => [];
}

class TodosLoading extends TodoState {
  const TodosLoading();

  @override
  List<Object?> get props => [];
}

class TodosLoaded extends TodoState {
  const TodosLoaded({required this.todos});

  final List<TodoModel> todos;

  @override
  List<Object?> get props => [todos];
}

class TodosFailed extends TodoState {
  const TodosFailed();

  @override
  List<Object?> get props => [];
}
