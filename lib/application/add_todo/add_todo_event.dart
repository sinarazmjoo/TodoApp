part of 'add_todo_bloc.dart';

@immutable
abstract class AddTodoEvent {}

class AddTodoTitleChanged extends AddTodoEvent {
  AddTodoTitleChanged({
    required this.title,
  });

  final String title;
}

class AddTodoDescriptionChanged extends AddTodoEvent {
  AddTodoDescriptionChanged({
    required this.description,
  });

  final String description;
}

class AddTodoButtonPressed extends AddTodoEvent {}

class ChangesTodoButtonPressed extends AddTodoEvent {
  ChangesTodoButtonPressed({
    required this.id,
  });
  final int id;
}

class AddTodoDateTimeChanged extends AddTodoEvent {
  AddTodoDateTimeChanged({
    required this.date,
  });
  final DateTime date;
}
