// ignore_for_file: unnecessary_type_check

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_todo_app/data/database_interface.dart';
import 'package:bloc_todo_app/models/filter.dart';
import 'package:bloc_todo_app/models/todo.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
part 'todo_list_event.dart';
part 'todo_list_state.dart';

class TodoListBloc extends Bloc<TodoListEvent, TodoListState> {
  TodoListBloc({required this.database}) : super(TodoListInitial()) {
    on<TodoListInitialized>((event, emit) => _todoListInitialized(event, emit));
    on<DeleteTodo>((event, emit) => _deleteTodo(event, emit));
    on<CheckForComplete>((event, emit) => _completeCheck(event, emit));
    on<FilterClassChanged>((event, emit) => _upDateFilter(event, emit));
    on<TodoModify>((event, emit) => _todoModify(event, emit));
  }
  IDatabase database;

  void _todoListInitialized(
    TodoListInitialized event,
    Emitter<TodoListState> emit,
  ) async {
    final todos = await getTaskFromDB();
    emit(TodoListLoading());
    await Future.delayed(const Duration(seconds: 2));
    emit(TodoListLoaded(
      todos: todos,
      filterclasss: FilterClass(),
      date: DateTime.now(),
    ));
  }

  void _deleteTodo(
    DeleteTodo event,
    Emitter<TodoListState> emit,
  ) async {
    final currentState = state as TodoListLoaded;

    database.delete<Todo>(event.id);

    final filteredList = await filterMethod(currentState.filterclass);
    emit(TodoListLoading());
    emit(
      currentState.copyWith(todos: filteredList, isDeleted: true),
    );
    emit(
      currentState.copyWith(todos: filteredList, isDeleted: false),
    );
  }

  void _completeCheck(
      CheckForComplete event, Emitter<TodoListState> emit) async {
    final currentState = state as TodoListLoaded;

    final todo = await database.read<Todo>(event.id);
    if (todo != null) {
      final updatedTodo = todo.copyWith(isCompleted: !todo.isCompleted);
      await database.update<Todo>(updatedTodo);
    }
    final filteredList = await filterMethod(currentState.filterclass);

    emit(
      TodoListLoaded(
        todos: filteredList,
        filterclasss: currentState.filterclass,
        date: currentState.filterclass.duoDate ?? DateTime.now(),
      ),
    );
  }

  Future<List<Todo>> filterMethod(FilterClass filterclass) async {
    final todos = await getTaskFromDB();
    List<Todo> filteredList = [];

    if (filterclass.duoDate != null && filterclass.justCompleted != null) {
      for (int i = 0; i < todos.length; i++) {
        if (DateFormat.yMd().format(todos[i].date) ==
                DateFormat.yMd().format(filterclass.duoDate!) &&
            todos[i].isCompleted == filterclass.justCompleted) {
          filteredList.add(todos[i]);
        }
      }
    } else {
      filteredList = todos;
    }

    return filteredList;
  }

  void _upDateFilter(
    FilterClassChanged event,
    Emitter<TodoListState> emit,
  ) async {
    final currentState = state as TodoListLoaded;
    final newState = currentState.copyWith(filterclass: event.filterClass);
    final filteredList = await filterMethod(event.filterClass);

    emit(
      TodoListLoaded(
        todos: filteredList,
        filterclasss: newState.filterclass,
        date: newState.filterclass.duoDate ?? DateTime.now(),
      ),
    );
  }

  Future<List<Todo>> getTaskFromDB() async {
    return await database.readAll<Todo>();
  }

  void _todoModify(TodoModify event, Emitter<TodoListState> emit) async {
    final currentState = state as TodoListLoaded;
    final filteredList = await filterMethod(currentState.filterclass);

    emit(
      TodoListLoaded(
        todos: filteredList,
        filterclasss: currentState.filterclass,
        date: currentState.filterclass.duoDate ?? DateTime.now(),
      ),
    );
  }
}
