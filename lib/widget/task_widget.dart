import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../provider/tasks.dart';

// Screen
import '../screen/add_task_scree.dart';

class TaskWidget extends StatelessWidget {
  final String id, title;
  final DateTime date;
  final TimeOfDay time;
  final Status? status;
  const TaskWidget(this.id, this.title, this.date, this.time, this.status,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Container(
        color: Colors.white,
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            child: FittedBox(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('${time.format(context)}'),
            )),
          ),
          title: Text(title),
          // leading: CircleAvatar(
          //   child: Text('$date'),
          // ),
          subtitle: Text('${DateFormat.yMMMd().format(date)}'),
        ),
      ),
      actions: [
        IconSlideAction(
          caption: 'Edit',
          color: Colors.yellow,
          icon: Icons.edit,
          onTap: () => Navigator.of(context)
              .pushNamed(AddTaskScreen.routeName, arguments: {
            'id': id,
          }),
        )
      ],
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () =>
              Provider.of<Tasks>(context, listen: false).removeTask(id),
        ),
        if (status != Status.InProgress)
          IconSlideAction(
            caption: 'In Progress',
            color: Colors.black45,
            icon: Icons.archive_outlined,
            onTap: () => Provider.of<Tasks>(context, listen: false)
                .changeStatus(id, Status.InProgress),
          ),
        if (status != Status.Completed)
          IconSlideAction(
            caption: 'Completed',
            color: Colors.blue,
            icon: Icons.done_all,
            onTap: () => Provider.of<Tasks>(context, listen: false)
                .changeStatus(id, Status.Completed),
          ),
      ],
    );
  }
}
