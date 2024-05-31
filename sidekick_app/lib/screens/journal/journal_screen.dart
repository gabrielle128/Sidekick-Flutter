import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sidekick_app/reusable_widgets/reusable_widget.dart';
import 'package:sidekick_app/screens/journal/edit_journal.dart';
import 'package:sidekick_app/screens/journal/journal_card.dart';
import 'package:sidekick_app/screens/journal/add_journal.dart';
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
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 34.0),
            const Center(
              child: Text(
                "Journal",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
              ),
            ),
            const SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
              width: double.infinity,
              height: 2,
              margin: EdgeInsets.symmetric(vertical: 8.0),
              child: CustomPaint(
                painter: DottedLinePainter(),
              ),
            ),
            // const SizedBox(height: 10.0),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("journal")
                    .doc(userId)
                    .collection(userEmail)
                    .orderBy("timestamp",
                        descending:
                            true) // Order by timestamp in descending order
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (snapshot.hasData) {
                    return ListView(
                      children: snapshot.data!.docs.map((journal) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: journalCard(context, () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    EditJournalScreen(journal),
                              ),
                            );
                          }, journal),
                        );
                      }).toList(),
                    );
                  }
                  return const Text("Empty List of Journal");
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: black,
        backgroundColor: yellow,
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return const AddJournalScreen();
            },
          );
        },
        child: const Icon(Icons.add),
        shape: const CircleBorder(),
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
