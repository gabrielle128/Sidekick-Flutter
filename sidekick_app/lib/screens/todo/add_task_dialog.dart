import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sidekick_app/reusable_widgets/reusable_widget.dart';
import 'package:sidekick_app/utils/colours.dart';

class AddTaskAlertDialog extends StatefulWidget {
  const AddTaskAlertDialog({
    super.key,
  });

  @override
  State<AddTaskAlertDialog> createState() => _AddTaskAlertDialogState();
}

class _AddTaskAlertDialogState extends State<AddTaskAlertDialog> {
  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController taskDescController = TextEditingController();
  final List<String> taskTags = ['Work', 'School', 'Other'];
  late String selectedValue = '';

  late String userId;
  late String userEmail;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return AlertDialog(
      scrollable: true,
      title: const Text(
        'New Task',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16, color: Colors.brown),
      ),
      content: SizedBox(
        height: height * 0.35,
        width: width,
        child: Form(
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: taskNameController,
                style: const TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  hintText: 'Task',
                  hintStyle: const TextStyle(fontSize: 14),
                  icon: const Icon(CupertinoIcons.square_list,
                      color: Colors.brown),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: taskDescController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                style: const TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  hintText: 'Description',
                  hintStyle: const TextStyle(fontSize: 14),
                  icon: const Icon(CupertinoIcons.bubble_left_bubble_right,
                      color: Colors.brown),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Row(
                children: <Widget>[
                  const Icon(CupertinoIcons.tag, color: Colors.brown),
                  const SizedBox(width: 15.0),
                  Expanded(
                    child: DropdownButtonFormField2(
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      isExpanded: true,
                      hint: const Text(
                        'Add a task tag',
                        style: TextStyle(fontSize: 14),
                      ),
                      items: taskTags
                          .map(
                            (item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (String? value) => setState(
                        () {
                          if (value != null) selectedValue = value;
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: grey,
          ),
          child: const Text(
            'Cancel',
            style: TextStyle(color: white),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            if (_validateFields()) {
              final taskName = taskNameController.text;
              final taskDesc = taskDescController.text;
              final taskTag = selectedValue;
              _addTasks(
                  taskName: taskName, taskDesc: taskDesc, taskTag: taskTag);
              Navigator.of(context, rootNavigator: true).pop();
            } else {
              // Show a toast indicating fields are empty
              if (mounted) {
                PopUpToast.showToast(context,
                    'An error occurred. Please fill in all the fields.');
              }
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: navy,
          ),
          child: const Text(
            'Save',
            style: TextStyle(color: white),
          ),
        ),
      ],
    );
  }

  bool _validateFields() {
    return taskNameController.text.isNotEmpty &&
        taskDescController.text.isNotEmpty &&
        selectedValue.isNotEmpty;
  }

  Future<void> _addTasks(
      {required String taskName,
      required String taskDesc,
      required String taskTag}) async {
    try {
      DocumentReference docRef = await FirebaseFirestore.instance
          .collection('tasks')
          .doc(userId)
          .collection(userEmail)
          .add(
        {
          'taskName': taskName,
          'taskDesc': taskDesc,
          'taskTag': taskTag,
        },
      );
      String taskId = docRef.id;
      await FirebaseFirestore.instance
          .collection('tasks')
          .doc(userId)
          .collection(userEmail)
          .doc(taskId)
          .update(
        {'id': taskId},
      );
      if (mounted) {
        // Showing a toast indicating task was added
        PopUpToast.showToast(context, 'Task added.');
      }
      _clearAll();
    } catch (e) {
      if (mounted) {
        PopUpToast.showToast(
            context, 'An error occurred while adding the task.');
      }
    }
  }

  void _clearAll() {
    taskNameController.text = '';
    taskDescController.text = '';
    selectedValue = '';
  }

  // get user id and email from firestore
  void getUser() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      userId = user.uid;
      userEmail = user.email!;
    }
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  void dispose() {
    taskNameController.dispose();
    taskDescController.dispose();
    super.dispose();
  }
}
