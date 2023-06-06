import 'package:bloc_todo_app/core/get_it.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../application/add_todo/add_todo_bloc.dart';
import '../models/todo.dart';

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({
    super.key,
    this.todo,
  });
  final Todo? todo;

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(
      text: widget.todo?.title,
    );
    _descriptionController = TextEditingController(
      text: widget.todo?.description,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AddTodoBloc>(param1: widget.todo),
      child: BlocConsumer<AddTodoBloc, AddTodoState>(
        listener: (context, state) {
          if (state is AddTodoSuccessfully) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          if (state is AddTodoFormState) {
            final bloc = context.read<AddTodoBloc>();
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  !state.isEdited == true ? 'Add Todo' : 'Edit Todo',
                ),
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(
                      context,
                    );
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
              ),
              body: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Title',
                      style: TextStyle(fontSize: 25),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Color.fromARGB(255, 210, 210, 210),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          borderSide:
                              BorderSide(width: 2, color: Colors.blueGrey),
                        ),
                        hintText: 'Enter  todo title',
                      ),
                      onChanged: (value) {
                        context.read<AddTodoBloc>().add(
                              AddTodoTitleChanged(title: value),
                            );
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Description',
                      style: TextStyle(fontSize: 25),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextField(
                      controller: _descriptionController,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Color.fromARGB(255, 210, 210, 210),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          borderSide:
                              BorderSide(width: 2, color: Colors.blueGrey),
                        ),
                        hintText: 'Description',
                      ),
                      onChanged: (value) {
                        context.read<AddTodoBloc>().add(
                              AddTodoDescriptionChanged(description: value),
                            );
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'picked Date :',
                            style: TextStyle(fontSize: 20),
                          ),
                          Row(
                            children: [
                              Text(
                                DateFormat.yMMMd().format(state.date),
                                style: const TextStyle(fontSize: 19),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  final pickedDate = await showDatePicker(
                                    context: context,
                                    firstDate: DateTime.now(),
                                    initialDate: DateTime.now(),
                                    lastDate: DateTime(2050),
                                  );

                                  bloc.add(
                                    AddTodoDateTimeChanged(
                                      date: pickedDate ?? DateTime.now(),
                                    ),
                                  );
                                },
                                child: const Icon(
                                  Icons.calendar_month_outlined,
                                  color: Colors.blueGrey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: const Color.fromARGB(255, 18, 109, 184),
                          shadowColor: Colors.purple, // Background color
                          onPrimary:
                              Colors.white, // Text Color (Foreground color)
                        ),
                        onPressed: () {
                          !state.isEdited
                              ? context
                                  .read<AddTodoBloc>()
                                  .add(AddTodoButtonPressed())
                              : context.read<AddTodoBloc>().add(
                                  ChangesTodoButtonPressed(
                                      id: widget.todo!.id));
                        },
                        child: Text(
                          !state.isEdited ? 'Add Todo' : 'Edit Todo',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is AddTodoSuccessfully) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return const Placeholder();
          }
        },
      ),
    );
  }
}
