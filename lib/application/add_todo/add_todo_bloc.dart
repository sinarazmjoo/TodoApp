import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:bloc_todo_app/data/database_interface.dart';
import 'package:flutter/cupertino.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import '../../models/todo.dart';
part 'add_todo_event.dart';
part 'add_todo_state.dart';

class AddTodoBloc extends Bloc<AddTodoEvent, AddTodoState> {
  AddTodoBloc({
    required this.database,
    this.todo,
  }) : super(AddTodoFormState.initialize(todo)) {
    on<AddTodoTitleChanged>((event, emit) => _addTodoTitleChanged(event, emit));
    on<AddTodoDescriptionChanged>(
        (event, emit) => _addTodoDescriptionChanged(event, emit));
    on<AddTodoButtonPressed>(
        (event, emit) => _addTodoButtonPressed(event, emit));
    on<ChangesTodoButtonPressed>(
        (event, emit) => _changeEditButtomPressed(event, emit));
    on<AddTodoDateTimeChanged>(
        (event, emit) => _addTodoDateTimeChanged(event, emit));
  }
  IDatabase database;
  final Todo? todo;

  void _addTodoTitleChanged(
    AddTodoTitleChanged event,
    Emitter<AddTodoState> emit,
  ) {
    final currentState = state as AddTodoFormState;
    final newState = currentState.copyWith(title: event.title);
    emit(newState);
  }

  void _addTodoDescriptionChanged(
    AddTodoDescriptionChanged event,
    Emitter<AddTodoState> emit,
  ) {
    final currentState = state as AddTodoFormState;
    final newState = currentState.copyWith(description: event.description);
    emit(newState);
  }

  void _addTodoDateTimeChanged(
      AddTodoDateTimeChanged event, Emitter<AddTodoState> emit) {
    final currentState = state as AddTodoFormState;
    final newState = currentState.copyWith(date: event.date);
    emit(newState);
  }

  int randomId() {
    var random = Random();

    int id = random.nextInt(1000000);
    return id;
  }

  void _addTodoButtonPressed(
    AddTodoButtonPressed event,
    Emitter<AddTodoState> emit,
  ) async {
    final currentState = state as AddTodoFormState;

    final Todo todo = Todo(
      id: randomId(),
      title: currentState.title,
      description: currentState.description,
      isCompleted: false,
      date: currentState.date,
    );
    await database.create<Todo>(todo);
    print(todo);
    emit(AddTodoSuccessfully());
  }

  void _changeEditButtomPressed(
      ChangesTodoButtonPressed event, Emitter<AddTodoState> emit) async {
    final currentState = state as AddTodoFormState;
    final todo = await database.read<Todo>(event.id);
    if (todo != null) {
      final editedTodo = todo.copyWith(
        title: currentState.title,
        description: currentState.description,
        date: currentState.date,
      );
      await database.update<Todo>(editedTodo);
      emit(AddTodoSuccessfully());
    }
  }
}
