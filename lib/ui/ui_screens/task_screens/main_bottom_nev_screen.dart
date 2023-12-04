

import 'package:flutter/material.dart';
import 'cancelled_tasks_screen.dart';
import 'completed_tasks_screen.dart';
import 'new_tasks_screen.dart';
import 'Progress_tasks_screen.dart';



class MainBottomNevScreen extends StatefulWidget {
  const MainBottomNevScreen({super.key});

  @override
  State<MainBottomNevScreen> createState() => _MainBottomNevScreenState();
}

class _MainBottomNevScreenState extends State<MainBottomNevScreen> {

  int _selectedIndex=0;
  final List<Widget> _screens=<Widget>[
    const NewTasksScreen(),
    const ProgressTasksScreen(),
    const CompletedTasksScreen(),
    const CancelledTasksScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index){
          setState(() {
            _selectedIndex=index;
          });

        },
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels:true,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.abc),label: "New"),
          BottomNavigationBarItem(icon: Icon(Icons.change_circle_outlined),label: "In Progress"),
          BottomNavigationBarItem(icon: Icon(Icons.done),label: "Completed"),
          BottomNavigationBarItem(icon: Icon(Icons.close),label: "Canceled"),

        ],
      ),
    ));
  }
}
