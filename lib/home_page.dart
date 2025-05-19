import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage();
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  late double _deviceHeight, _deviceWidth;
  _HomePageState();
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
      body: _tasksList(),
    );
  }

  Widget _tasksList() {
    return ListView(
      children: [
        ListTile(
          title: const Text(
            'Do the laundry',
            style: TextStyle(
              fontSize: 20,
              decoration: TextDecoration.lineThrough,
            ),
          ),
          subtitle: Text(DateTime.now().toString()),
          trailing: const Icon(Icons.check_box_outlined, color: Colors.red),
          onTap: () {
            // Handle task tap
          },
        ),
        ListTile(
          title: const Text(
            'Do the laundry',
            style: TextStyle(
              fontSize: 20,
              decoration: TextDecoration.lineThrough,
            ),
          ),
          subtitle: Text(DateTime.now().toString()),
          trailing: const Icon(Icons.check_box_outlined, color: Colors.red),
          onTap: () {
            // Handle task tap
          },
        ),
      ],
    );
  }
}
