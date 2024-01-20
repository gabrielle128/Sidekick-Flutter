import 'package:flutter/material.dart';
import 'package:sidekick_app/utils/colours.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: black,
        title: Text("Feedback", style: TextStyle(color: black)),
        centerTitle: true,
        backgroundColor: yellow,
      ),
      body: Center(
        child: Text(
          "Feedback",
          style: TextStyle(fontSize: 50),
        ),
      ),
    );
  }
}
