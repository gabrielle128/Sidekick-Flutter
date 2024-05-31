import 'package:flutter/material.dart';
import 'package:sidekick_app/reusable_widgets/reusable_widget.dart';
import 'package:sidekick_app/screens/todo/add_task_dialog.dart';
import 'package:sidekick_app/screens/todo/tasks.dart';
import 'package:sidekick_app/screens/todo/categories.dart';
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
      body: Container(
        margin: EdgeInsets.symmetric(
            horizontal: 16.0), // Add margin to the left and right
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 50.0), // Added space above the "To-Do" text
            const Center(
              child: Text(
                "To-Do",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
              ),
            ),
            const SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
              width: double.infinity,
              height: 2, // Increase the height to make the dotted line visible
              margin: EdgeInsets.symmetric(vertical: 8.0),
              child: CustomPaint(
                painter: DottedLinePainter(),
              ),
            ),
            Expanded(
              child: PageView(
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
            ),
          ],
        ),
      ),
      extendBody: true,
      floatingActionButton: FloatingActionButton(
        foregroundColor: black,
        backgroundColor: yellow,
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return const AddTaskAlertDialog();
            },
          );
        },
        child: const Icon(Icons.add),
        shape: const CircleBorder(),
      ),
    );
  }
}
