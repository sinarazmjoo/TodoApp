import 'package:bloc_todo_app/models/filter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({
    Key? key,
    required this.filterClass,
  }) : super(key: key);
  final FilterClass filterClass;
  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  late bool justCompleted;
  late DateTime dateTime;
  @override
  void initState() {
    super.initState();
    justCompleted = widget.filterClass.justCompleted ?? false;
    dateTime = widget.filterClass.duoDate ?? DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return SizedBox(
          height: 400,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Column(
              children: [
                const Text(
                  'Filter Tasks by : ',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    color: Colors.indigo,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Due Date ',
                      style: TextStyle(fontSize: 20),
                    ),
                    Row(
                      children: [
                        Text(
                          DateFormat.yMd().format(dateTime),
                          style: const TextStyle(fontSize: 20),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () async {
                            DateTime? datePicker = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now()
                                  .subtract(const Duration(days: 365)),
                              lastDate:
                                  DateTime.now().add(const Duration(days: 365)),
                            );
                            if (datePicker != null) {
                              setState(
                                () {
                                  dateTime = datePicker;
                                },
                              );
                            } else {
                              dateTime = DateTime.now();
                            }
                          },
                          child: const Icon(
                            Icons.calendar_month,
                            color: Colors.black,
                            size: 25,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'JustCompleted',
                      style: TextStyle(fontSize: 20),
                    ),
                    CupertinoSwitch(
                        value: justCompleted,
                        onChanged: (value) {
                          setState(() {
                            justCompleted = value;
                          });
                        }),
                  ],
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(
                        context,
                        FilterClass(
                          duoDate: dateTime,
                          justCompleted: justCompleted,
                        ),
                      );
                    },
                    child: const Text('search'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
