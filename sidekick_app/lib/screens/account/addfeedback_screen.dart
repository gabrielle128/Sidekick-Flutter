import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sidekick_app/reusable_widgets/reusable_widget.dart';
import 'package:sidekick_app/utils/colours.dart';

class AddFeedback extends StatefulWidget {
  const AddFeedback({
    super.key,
  });

  @override
  State<AddFeedback> createState() => _AddFeedbackState();
}

class _AddFeedbackState extends State<AddFeedback> {
  final TextEditingController feedbackController = TextEditingController();
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
        'Send us your feedback!',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16, color: Colors.black),
      ),
      content: SizedBox(
        height: height * 0.1,
        width: width,
        child: Form(
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: feedbackController,
                style: const TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  hintText: 'Enter your feedback or suggestions here',
                  hintStyle: const TextStyle(fontSize: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
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
              final feedback = feedbackController.text;
              _addFeedback(feedback: feedback);
              Navigator.of(context, rootNavigator: true).pop();
            } else {
              //Show a toast indicating fields are empty
              PopUpToast.showToast(
                  context, 'An error occurred. Please fill in all the fields.');
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
    return feedbackController.text.isNotEmpty;
  }

  Future<void> _addFeedback({required String feedback}) async {
    CollectionReference feedbacks =
        FirebaseFirestore.instance.collection('feedbacks');
    feedbacks.add({
      'userEmail': userEmail,
      'feedback': feedback,
      'timestamp': FieldValue.serverTimestamp(),
    });
    //Showing a toast indicating task was added
    PopUpToast.showToast(context, 'Your feedback has been sent.');
    _clearAll();
  }

  void _clearAll() {
    feedbackController.text = '';
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
}
