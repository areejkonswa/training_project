import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Provider
import '../provider/tasks.dart';

// Screen
import './tasks_screen.dart';
import './in_progress_screen.dart';
import './completed_screen.dart';
import './add_task_scree.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  late List<Map<String, dynamic>> _pages;
  void _changePage(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  // List<Task> filterTasks({Status? status}) {
  //   return _tasks.where((element) => element.status == status).toList();
  // }

  @override
  void initState() {
    _pages = [
      {
        'title': 'Tasks',
        'page': TasksScreen(),
      },
      {'title': 'InProgress', 'page': InProgressScreen()},
      {
        'title': 'Completed',
        'page': CompletedScreen(),
      },
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_currentIndex]['title']),
      ),
      body: FutureBuilder(
        future: Provider.of<Tasks>(context).getData(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return _pages[_currentIndex]['page'];
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _changePage,
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.task_alt),
            label: 'Taks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.archive),
            label: 'In Progress',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.done_all),
            label: 'Completed',
          ),
        ],
      ),
      floatingActionButton: _currentIndex == 0
          ? FloatingActionButton(
              onPressed: () =>
                  Navigator.pushNamed(context, AddTaskScreen.routeName),
              child: Icon(Icons.add),
            )
          : null,
    );
  }
}
