import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:math';

class EventFirestore {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late String userId;
  late String userEmail;

  void getUser() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      userId = user.uid;
      userEmail = user.email!;
    }
  }

  // Additional methods for Firestore operations related to events
  // ...

  // Example method for adding an event to Firestore
  Future<void> addEventToFirestore(
      String title, String description, DateTime date) async {
    final newEventId = Random().nextInt(999999).toString();

    // Add the event to Firestore
    try {
      await _firestore
          .collection('events')
          .doc(userId)
          .collection(userEmail)
          .doc(newEventId)
          .set({
        'title': title,
        'description': description,
        'date': date.toIso8601String(),
      });
    } catch (e) {
      // Handle error
      return;
    }
  }

  // Other methods for updating, deleting, and fetching events from Firestore
  // ...
}
