part of 'todo_list_bloc.dart';

@immutable
abstract class TodoListEvent {}

class TodoListInitialized extends TodoListEvent {}

class TodoListUpdated extends TodoListEvent {}

class DeleteTodo extends TodoListEvent {
  DeleteTodo({
    required this.id,
  });
  final int id;
}

class CheckForComplete extends TodoListEvent {
  CheckForComplete({
    required this.id,
  });
  final int id;
}

class FilterClassChanged extends TodoListEvent {
  FilterClassChanged({
    required this.filterClass,
  });
  final FilterClass filterClass;
}

class TodoModify extends TodoListEvent {}
