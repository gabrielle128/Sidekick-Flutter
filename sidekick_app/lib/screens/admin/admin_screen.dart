import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sidekick_app/reusable_widgets/reusable_widget.dart';
import 'package:sidekick_app/routes.dart';
import 'package:sidekick_app/utils/colours.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Admin Panel",
          style: TextStyle(color: black),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.close),
          color: black, // X button icon
          onPressed: () {
            exitApp();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            color: black, // Logout button icon
            onPressed: () {
              signOut();
            },
          ),
        ],
        backgroundColor: yellow,
      ),
      body: Center(
        child: Padding(
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              adminButton(context, yellow, 'View Users', () {
                Navigator.pushNamed(context, AppRoutes.users);
              }),
              SizedBox(height: 16), // Add some spacing between the buttons
              adminButton(context, yellow, 'View Feedback', () {
                Navigator.pushNamed(context, AppRoutes.feedback);
              }),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> exitApp() async {
    // Handle any cleanup or additional actions before exiting the app
    // ...

    // Exit the app
    Navigator.pop(context);
  }

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pop(context); // Pop the AdminScreen from the stack
    } catch (e) {
      print("Error signing out: $e");
      // Handle sign-out error if needed
    }
  }
}
