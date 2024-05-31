import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sidekick_app/reusable_widgets/reusable_widget.dart';
import 'package:sidekick_app/screens/journal/app_style.dart';
import 'package:sidekick_app/screens/journal/color_picker_dialog.dart';
import 'package:sidekick_app/utils/sidekick_icons_icons.dart';

class EditJournalScreen extends StatefulWidget {
  EditJournalScreen(this.doc, {Key? key}) : super(key: key);
  final QueryDocumentSnapshot doc;

  @override
  State<EditJournalScreen> createState() => _EditJournalScreenState();
}

class _EditJournalScreenState extends State<EditJournalScreen> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  late Color selectedColor; // Add selectedColor variable

  late String userId;
  late String userEmail;

  @override
  void initState() {
    super.initState();
    getUser();
    _titleController = TextEditingController(text: widget.doc["journal_title"]);
    _contentController =
        TextEditingController(text: widget.doc["journal_content"]);
    selectedColor = Color(widget
        .doc["journal_color"]); // Initialize selectedColor with journal_color
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: selectedColor, // Use selectedColor for background color
      appBar: AppBar(
        backgroundColor: selectedColor, // Use selectedColor for app bar color
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          "Edit Journal",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(SidekickIcons.colorPalette),
            color: Colors.black,
            onPressed: () {
              showColorPickerDialog(context, selectedColor, (Color color) {
                setState(() {
                  selectedColor = color; // Update selected color
                });
              });
            },
          ),
          IconButton(
            icon: Icon(SidekickIcons.save),
            color: Colors.black,
            onPressed: () {
              FirebaseFirestore.instance
                  .collection("journal")
                  .doc(userId)
                  .collection(userEmail)
                  .doc(widget.doc.id)
                  .update({
                "journal_title": _titleController.text,
                "journal_content": _contentController.text,
                "journal_color": selectedColor
                    .value, // Update journal_color with selectedColor value
              }).then((value) {
                PopUpToast.showToast(context, 'Journal updated.');
                Navigator.pop(context); // Go back to previous screen
              }).catchError((error) {
                PopUpToast.showToast(context, 'Failed to update journal.');
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                widget.doc["formatted_timestamp"],
                style: AppStyle.mainDate,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Title',
                hintStyle: AppStyle.mainTitle,
              ),
              style: AppStyle.mainTitle,
              onChanged: (value) {
                setState(() {});
              },
            ),
            Container(
              width: double.infinity,
              height: 1,
              margin: EdgeInsets.symmetric(vertical: 8.0),
              child: CustomPaint(
                painter: DottedLinePainter(),
              ),
            ),
            Expanded(
              child: TextField(
                controller: _contentController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Content',
                  hintStyle: AppStyle.mainContent,
                ),
                style: AppStyle.mainContent,
                maxLines: null,
                onChanged: (value) {
                  setState(() {});
                },
              ),
            ),
          ],
        ),
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
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }
}
