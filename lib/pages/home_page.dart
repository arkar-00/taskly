import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskly/models/task.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  late double _deviceHeight, _deviceWidth;

  String? _newTaskContent;
  Box? _box;

  _HomePageState();

  @override
  void initState() {
    super.initState();
    // Initialize Hive and open the box here if needed
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Taskly!',
          style: TextStyle(fontSize: 25, color: Colors.white),
        ),
        backgroundColor: Colors.red,
        toolbarHeight: _deviceHeight * 0.15,
      ),
      body: _tasksView(),
      floatingActionButton: _addTaskButton(),
    );
  }

  Widget _tasksView() {
    return FutureBuilder(
      future: Hive.openBox('tasks'),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          _box = snapshot.data;
          // You can replace this with your actual widget when data is available
          return _tasksList();
        } else {
          return const Center(
            child: CircularProgressIndicator(color: Colors.red),
          );
        }
      },
    );
  }

  Widget _tasksList() {
    List tasks = _box!.values.toList();
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        Task task = Task.fromMap(tasks[index]);
        return ListTile(
          title: Text(
            task.content,
            style: TextStyle(
              fontSize: 20,
              decoration: task.isDone ? TextDecoration.lineThrough : null,
            ),
          ),
          subtitle: Text(task.timestamp.toString()),
          trailing: Icon(
            task.isDone
                ? Icons.check_box_outlined
                : Icons.check_box_outline_blank,
            color: Colors.red,
          ),
          onTap: () {
            // Handle task tap
          },
        );
      },
    );
  }

  Widget _addTaskButton() {
    return FloatingActionButton(
      shape: const CircleBorder(),
      onPressed: _showAddTaskDialog,
      backgroundColor: Colors.red,
      child: const Icon(Icons.add, size: 30, color: Colors.white),
    );
  }

  void _showAddTaskDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Task'),
          content: TextField(
            decoration: const InputDecoration(hintText: 'Enter task here'),
            onSubmitted: (value) {
              if (_newTaskContent != null) {
                var task = Task(
                  content: _newTaskContent!,
                  timestamp: DateTime.now(),
                  isDone: false,
                );
                _box!.add(task.toMap());
                setState(() {
                  _newTaskContent = null;
                });
                Navigator.of(context).pop();
              }
            },
            onChanged: (value) {
              setState(() {
                _newTaskContent = value;
              });
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
