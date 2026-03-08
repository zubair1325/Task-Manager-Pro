import 'package:flutter/material.dart';
import 'package:task_manager_pro/ui/screens/cancel_task.dart';
import 'package:task_manager_pro/ui/screens/complected_task.dart';
import 'package:task_manager_pro/ui/screens/new_task_screen.dart';
import 'package:task_manager_pro/ui/screens/progress_task_screen.dart';

class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({super.key});

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    NewTaskScreen(),
    ProgressTaskScreen(),
    ComplectedTask(),
    CancelTask(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        onTap: (value) {
          _selectedIndex = value;
          setState(() {});
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.pages), label: "New"),
          BottomNavigationBarItem(
            icon: Icon(Icons.change_circle_outlined),
            label: "In Progress",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.done), label: "Complected"),
          BottomNavigationBarItem(icon: Icon(Icons.cancel), label: "Cancel"),
        ],
      ),
    );
  }
}
