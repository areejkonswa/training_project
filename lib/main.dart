import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

// Screen
import './screen/home_screen.dart';
import './screen/add_task_scree.dart';

// Provider
import './provider/tasks.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: Tasks(),
      child: MaterialApp(
        routes: {
          '/': (_) => HomeScreen(),
          AddTaskScreen.routeName: (ctx) => AddTaskScreen(),
        },
      ),
    );
  }
}
