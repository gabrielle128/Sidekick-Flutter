import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sidekick_app/reusable_widgets/reusable_widget.dart';
import 'package:sidekick_app/utils/colours.dart';

class UpdateTaskAlertDialog extends StatefulWidget {
  final String taskId, taskName, taskDesc, taskTag;

  const UpdateTaskAlertDialog(
      {super.key,
      required this.taskId,
      required this.taskName,
      required this.taskDesc,
      required this.taskTag});

  @override
  State<UpdateTaskAlertDialog> createState() => _UpdateTaskAlertDialogState();
}

class _UpdateTaskAlertDialogState extends State<UpdateTaskAlertDialog> {
  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController taskDescController = TextEditingController();
  final List<String> taskTags = ['Work', 'School', 'Other'];
  String selectedValue = '';
  bool updateError = false;

  late String userId;
  late String userEmail;

  @override
  Widget build(BuildContext context) {
    taskNameController.text = widget.taskName;
    taskDescController.text = widget.taskDesc;

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return AlertDialog(
      scrollable: true,
      title: const Text(
        'Update Task',
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
                      value: widget.taskTag,
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
          style: ElevatedButton.styleFrom(backgroundColor: navy),
          onPressed: () async {
            final taskName = taskNameController.text;
            final taskDesc = taskDescController.text;
            var taskTag = '';
            selectedValue == ''
                ? taskTag = widget.taskTag
                : taskTag = selectedValue;
            // Check if any of the fields is empty
            if (taskName.isEmpty || taskDesc.isEmpty || taskTag.isEmpty) {
              if (mounted) {
                PopUpToast.showToast(context, 'Empty fields are not accepted.');
              }
              setState(() {
                updateError = true;
              });
              return;
            }

            await _updateTasks(taskName, taskDesc, taskTag);
            if (!updateError && mounted) {
              Navigator.of(context, rootNavigator: true).pop();
            }
          },
          child: const Text(
            'Update',
            style: TextStyle(color: white),
          ),
        ),
      ],
    );
  }

  Future<void> _updateTasks(
      String taskName, String taskDesc, String taskTag) async {
    try {
      var collection = FirebaseFirestore.instance
          .collection('tasks')
          .doc(userId)
          .collection(userEmail);
      await collection.doc(widget.taskId).update(
          {'taskName': taskName, 'taskDesc': taskDesc, 'taskTag': taskTag});
      if (mounted) {
        PopUpToast.showToast(context, 'Task updated successfully.');
      }
      // Clear the text fields after successful update
      taskNameController.clear();
      taskDescController.clear();
      selectedValue = '';
      setState(() {
        updateError = false;
      });
    } catch (error) {
      if (mounted) {
        PopUpToast.showToast(context, 'Failed to update task: $error');
      }
      setState(() {
        updateError = true;
      });
    }
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
