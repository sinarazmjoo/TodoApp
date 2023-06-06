import 'package:bloc_todo_app/application/add_todo/add_todo_bloc.dart';
import 'package:bloc_todo_app/application/todo_list/todo_list_bloc.dart';
import 'package:bloc_todo_app/data/database.dart';
import 'package:bloc_todo_app/data/database_interface.dart';

import 'package:bloc_todo_app/models/todo.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

void setupGetIt() {
  getIt.registerSingleton<IDatabase>(Database());
  getIt.registerFactory<TodoListBloc>(
    () => TodoListBloc(
      database: getIt<IDatabase>(),
    ),
  );
  getIt.registerFactoryParam<AddTodoBloc, Todo?, void>(
    (todo, _) => AddTodoBloc(
      database: getIt<IDatabase>(),
      todo: todo,
    ),
  );
}
