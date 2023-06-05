part of 'todo_list_bloc.dart';

@immutable
abstract class TodoListState {}

class TodoListInitial extends TodoListState {}

class TodoListLoading extends TodoListState {}

class TodoListLoaded extends TodoListState {
  TodoListLoaded({
    required this.todos,
    this.isDeleted = false,
    required this.date,
    filterclasss,
  }) {
    filterclass = filterclasss ?? FilterClass();
  }

  final List<Todo> todos;
  final bool isDeleted;
  final DateTime date;
  late final FilterClass filterclass;
  @override
  String toString() => 'TodoListLoaded(todos: $todos)';

  TodoListLoaded copyWith({
    List<Todo>? todos,
    bool? isDeleted,
    bool? isCompleted,
    DateTime? date,
    FilterClass? filterclass,
  }) {
    return TodoListLoaded(
        todos: todos ?? this.todos,
        isDeleted: isDeleted ?? this.isDeleted,
        date: date ?? this.date,
        filterclasss: filterclass ?? this.filterclass);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TodoListLoaded &&
        listEquals(other.todos, todos) &&
        other.isDeleted == isDeleted &&
        other.date == date &&
        other.filterclass == filterclass;
  }

  @override
  int get hashCode =>
      todos.hashCode ^
      isDeleted.hashCode ^
      date.hashCode ^
      filterclass.hashCode;
}
