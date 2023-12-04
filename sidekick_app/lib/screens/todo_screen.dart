// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sidekick_app/screens/todocrud/add_task_dialogue.dart';
import 'package:sidekick_app/screens/todo/tasks.dart';
import 'package:sidekick_app/screens/todo/categories.dart';
import 'package:sidekick_app/screens/account/account_screen.dart';
import 'package:sidekick_app/sidekick_icons_icons.dart';
import 'package:sidekick_app/utils/colours.dart';

class ToDoScreen extends StatefulWidget {
  const ToDoScreen({super.key});

  @override
  State<ToDoScreen> createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  final PageController pageController = PageController(initialPage: 0);
  // late final int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 90,
        actions: <Widget>[
          Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 30, 0),
              child: IconButton(
                icon: const Icon(
                  SidekickIcons.account,
                  color: black,
                  size: 50,
                ),
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AccountScreen())),
              ))
        ],
      ),
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: const Text("To-Do List"),
      //   actions: [
      //     IconButton(
      //       onPressed: () {},
      //       icon: const Icon(CupertinoIcons.calendar),
      //     ),
      //   ],
      // ),
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
  }
}
