// ignore_for_file: use_build_context_synchronously

import 'package:bloc_todo_app/application/todo_list/todo_list_bloc.dart';
import 'package:bloc_todo_app/models/todo.dart';
import 'package:bloc_todo_app/veiw/add_todo_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoCard extends StatelessWidget {
  const TodoCard({
    Key? key,
    required this.todo,
  }) : super(key: key);
  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      color: Colors.blue[100],
      child: Padding(
        padding: const EdgeInsets.only(top: 15, right: 15, bottom: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          context.read<TodoListBloc>().add(
                                CheckForComplete(id: todo.id),
                              );
                        },
                        child: todo.isCompleted == true
                            ? const Icon(Icons.check_box)
                            : const Icon(Icons.square_outlined),
                      ),
                    ),
                    Text(
                      todo.title,
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Text(
                  '${todo.date.year}/${todo.date.month}/${todo.date.day}',
                  style: const TextStyle(fontSize: 15),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 45),
                  child: Text(
                    todo.description,
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        context.read<TodoListBloc>().add(
                              DeleteTodo(id: todo.id),
                            );
                      },
                      child: const Icon(Icons.delete),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddTodoPage(
                              todo: todo,
                            ),
                          ),
                        );
                        context.read<TodoListBloc>().add(TodoModify());
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('edit todo was successfull'),
                          ),
                        );
                      },
                      child: const Icon(Icons.mode_edit),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
