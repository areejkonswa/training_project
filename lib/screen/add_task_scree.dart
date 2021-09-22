import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

// Provider
import '../provider/tasks.dart';

class AddTaskScreen extends StatefulWidget {
  static const routeName = '/add_task_screen';
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  bool _isFirst = true;
  var _args;
  var _titleController = TextEditingController();
  var _timeController = TextEditingController();
  var _dateController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  // @override
  // void initState() {
  //   super.initState();
  // }

  @override
  void didChangeDependencies() {
    if (_isFirst) {
      _args = ModalRoute.of(context)!.settings.arguments;
      print(_args);
      _isFirst = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Task? task;
    if (_args != null) {
      task = Provider.of<Tasks>(context).findById(_args['id']);
      _titleController.text = task.title;
      _timeController.text = task.time.format(context);
      _dateController.text = DateFormat.yMMMd().format(task.date);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(_args == null ? 'Add Task' : 'Edit Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Title',
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: _timeController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Time',
              ),
              readOnly: true,
              onTap: () {
                showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                ).then(
                  (value) => setState(
                    () {
                      _selectedTime = value ?? TimeOfDay.now();
                      _timeController.text = value?.format(context) ?? '';
                    },
                  ),
                );
              },
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: _dateController,
              keyboardType: TextInputType.datetime,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Date',
              ),
              readOnly: true,
              onTap: () {
                showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(
                    Duration(days: 7),
                  ),
                ).then(
                  (value) => setState(() {
                    _selectedDate = value ?? DateTime.now();
                    _dateController.text =
                        DateFormat.yMMMd().format(value ?? DateTime.now());
                  }),
                );
              },
            ),
            ElevatedButton(
                onPressed: () {
                  _args == null
                      ? Provider.of<Tasks>(context, listen: false).addTask(
                          _titleController.text,
                          _selectedDate,
                          _selectedTime,
                        )
                      : Provider.of<Tasks>(context, listen: false).updateTask(
                          _args['id'],
                          _titleController.text,
                          _selectedDate,
                          _selectedTime,
                        );
                  Navigator.pop(context);
                },
                child: Text(_args == null ? 'Add Task' : 'Edit Task'))
          ],
        ),
      ),
    );
  }
}
