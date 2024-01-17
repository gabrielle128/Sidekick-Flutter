//import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:sidekick_app/sidekick_icons_icons.dart';
//import 'package:sidekick_app/utils/colours.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:sidekick_app/reusable_widgets/journal_card.dart';
import 'package:sidekick_app/screens/account/account_screen.dart';
import 'package:sidekick_app/screens/journal_reader.dart';
import 'package:sidekick_app/screens/journal_editor.dart';
import 'package:sidekick_app/sidekick_icons_icons.dart';
import 'package:sidekick_app/utils/colours.dart';

class JournalScreen extends StatefulWidget {
  const JournalScreen({super.key});

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  late String userId;
  late String userEmail;

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
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Your Journal",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35)),
              const SizedBox(
                height: 20.0,
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("journal")
                      .doc(userId)
                      .collection(userEmail)
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (snapshot.hasData) {
                      return GridView(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2),
                        children: snapshot.data!.docs
                            .map((journal) => journalCard(() {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            JournalReaderScreen(journal),
                                      ));
                                }, journal))
                            .toList(),
                      );
                    }
                    return const Text(
                      "Empty List of Journal",
                    );
                  },
                ),
              )
            ],
          )),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const JournalEditorScreen()));
        },
        label: const Text("Add Journal"),
        icon: const Icon(Icons.add),
      ),
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
