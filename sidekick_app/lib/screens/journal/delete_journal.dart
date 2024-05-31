import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sidekick_app/reusable_widgets/reusable_widget.dart';
import 'package:sidekick_app/utils/colours.dart';

class DeleteJournalDialogue extends StatefulWidget {
  final QueryDocumentSnapshot doc;

  DeleteJournalDialogue(this.doc, {Key? key}) : super(key: key);

  @override
  State<DeleteJournalDialogue> createState() => _DeleteJournalDialogueState();
}

class _DeleteJournalDialogueState extends State<DeleteJournalDialogue> {
  late String userId;
  late String userEmail;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: const Text(
        'Delete Journal',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16, color: Colors.brown),
      ),
      content: SizedBox(
        child: Form(
          child: Column(
            children: const <Widget>[
              Text(
                'Are you sure you want to delete this journal?',
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(height: 15)
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
            widget.doc.reference.delete();
            PopUpToast.showToast(context, 'Your journal has been deleted.');
            Navigator.of(context, rootNavigator: true).pop();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: navy,
          ),
          child: const Text(
            'Delete',
            style: TextStyle(color: white),
          ),
        ),
      ],
    );
  }

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
