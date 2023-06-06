// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, use_build_context_synchronously
import 'package:bloc_todo_app/core/get_it.dart';
import 'package:bloc_todo_app/veiw/custom_bottom_sheet.dart';
import 'package:bloc_todo_app/veiw/todo_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_todo_app/application/todo_list/todo_list_bloc.dart';
import 'package:bloc_todo_app/veiw/add_todo_page.dart';
import 'package:intl/intl.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<TodoListBloc>()..add(TodoListInitialized()),
      child: BlocConsumer<TodoListBloc, TodoListState>(
        listener: (context, state) {
          if (state is TodoListLoaded && state.isDeleted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Delete Todo was successful'),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is TodoListInitial || state is TodoListLoading) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is TodoListLoaded) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.blue[400],
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'HOME',
                        style: TextStyle(
                          color: Colors.indigo[800],
                        ),
                      ),
                      const SizedBox(
                        width: 60,
                      ),
                      Text(
                        state.filterclass.duoDate == null
                            ? DateFormat.yMMMd().format(DateTime.now())
                            : DateFormat.yMMMd().format(state.date),
                        style: const TextStyle(fontSize: 19),
                      ),
                      GestureDetector(
                        onTap: () async {
                          final filterClass = await showModalBottomSheet(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(25.0),
                              ),
                            ),
                            context: context,
                            builder: (context) {
                              return FilterBottomSheet(
                                filterClass: state.filterclass,
                              );
                            },
                          );
                          if (filterClass != null) {
                            context.read<TodoListBloc>().add(
                                  FilterClassChanged(filterClass: filterClass),
                                );
                          }
                        },
                        child: const Icon(
                          Icons.filter_list_outlined,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              body: ListView.builder(
                padding: EdgeInsets.all(16.0),
                itemCount: state.todos.length,
                itemBuilder: (context, index) {
                  final todo = state.todos[index];
                  return TodoCard(
                    todo: todo,
                  );
                },
              ),
              floatingActionButton: FloatingActionButton(
                backgroundColor: Colors.blue[400],
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddTodoPage(),
                    ),
                  );
                  context.read<TodoListBloc>().add(TodoModify());

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('add todo was successfully'),
                    ),
                  );
                },
                child: Icon(
                  Icons.add,
                ),
              ),
            );
          } else {
            return Placeholder();
          }
        },
      ),
    );
  }
}
