// ignore_for_file: prefer_if_null_operators

part of 'add_todo_bloc.dart';

@immutable
abstract class AddTodoState {}

class AddTodoSuccessfully extends AddTodoState {}

class AddTodoFormState extends AddTodoState {
  AddTodoFormState({
    required this.title,
    required this.description,
    required this.isEdited,
    required this.date,
  });

  final String title;
  final String description;
  final bool isEdited;
  final DateTime date;

  factory AddTodoFormState.initialize(Todo? todo) {
    return AddTodoFormState(
      title: todo != null ? todo.title : '',
      description: todo?.description ?? '',
      isEdited: todo != null ? true : false,
      date: todo != null ? todo.date : DateTime.now(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AddTodoFormState &&
        other.title == title &&
        other.description == description &&
        other.isEdited == isEdited &&
        other.date == date;
  }

  @override
  int get hashCode =>
      title.hashCode ^ description.hashCode ^ isEdited.hashCode ^ date.hashCode;

  @override
  String toString() =>
      'AddTodoFormState(title: $title, description: $description, isEdited: $isEdited, date: $date)';

  AddTodoFormState copyWith({
    String? title,
    String? description,
    bool? isEdited,
    DateTime? date,
  }) {
    return AddTodoFormState(
      title: title ?? this.title,
      description: description ?? this.description,
      isEdited: isEdited ?? this.isEdited,
      date: date ?? this.date,
    );
  }
}
