import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Model
import '../provider/tasks.dart';

// Widget
import '../widget/task_widget.dart';

class InProgressScreen extends StatelessWidget {
  const InProgressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _tasks =
        Provider.of<Tasks>(context).filterTasks(status: Status.InProgress);
    return ListView.separated(
        itemBuilder: (ctx, index) => TaskWidget(
              _tasks[index].id,
              _tasks[index].title,
              _tasks[index].date,
              _tasks[index].time,
              _tasks[index].status,
            ),
        separatorBuilder: (ctx, index) => Divider(
              thickness: 2,
              height: 0,
            ),
        itemCount: _tasks.length);
  }
}
