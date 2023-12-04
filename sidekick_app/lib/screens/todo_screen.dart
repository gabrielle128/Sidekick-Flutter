<<<<<<< HEAD
<<<<<<< HEAD
import 'package:flutter/material.dart';
=======
// import 'package:flutter/cupertino.dart';
=======
import 'package:flutter/cupertino.dart';
>>>>>>> parent of 452d2cf (may catching errors na sheesh pushing)
import 'package:flutter/material.dart';
import 'package:sidekick_app/screens/todocrud/add_task_dialogue.dart';
import 'package:sidekick_app/screens/todo/tasks.dart';
import 'package:sidekick_app/screens/todo/categories.dart';
<<<<<<< HEAD
import 'package:sidekick_app/screens/account/account_screen.dart';
import 'package:sidekick_app/sidekick_icons_icons.dart';
import 'package:sidekick_app/utils/colours.dart';
>>>>>>> 452d2cf9c1483d606df6420f29272e714e3cad5a
=======
>>>>>>> parent of 452d2cf (may catching errors na sheesh pushing)

class ToDoScreen extends StatefulWidget {
  const ToDoScreen({super.key});

  @override
  State<ToDoScreen> createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
<<<<<<< HEAD
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
      child: Text(
        "To Do Screen",
        style: TextStyle(fontSize: 40),
      ),
    ));
=======
  final PageController pageController = PageController(initialPage: 0);
  late int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("To-Do List"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(CupertinoIcons.calendar),
          ),
        ],
      ),
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return const AddTaskAlertDialog();
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 6.0,
        clipBehavior: Clip.antiAlias,
        child: SizedBox(
          height: kBottomNavigationBarHeight,
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.brown,
            unselectedItemColor: Colors.black,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
                pageController.jumpToPage(index);
              });
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.square_list),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.tag),
                label: '',
              ),
            ],
          ),
        ),
      ),
      body: PageView(
        controller: pageController,
        children: const <Widget>[
          Center(
            child: Tasks(),
          ),
          Center(
            child: Categories(),
          ),
        ],
      ),
    );
>>>>>>> 452d2cf9c1483d606df6420f29272e714e3cad5a
  }
}
