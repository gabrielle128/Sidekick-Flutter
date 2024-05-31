import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sidekick_app/reusable_widgets/reusable_widget.dart';
import 'package:sidekick_app/screens/journal/app_style.dart';
import 'package:sidekick_app/screens/journal/color_picker_dialog.dart';
import 'package:sidekick_app/utils/sidekick_icons_icons.dart';
import 'package:sidekick_app/utils/colours.dart';

class AddJournalScreen extends StatefulWidget {
  const AddJournalScreen({Key? key}) : super(key: key);

  @override
  State<AddJournalScreen> createState() => _AddJournalScreenState();
}

class _AddJournalScreenState extends State<AddJournalScreen> {
  late Color selectedColor;
  TextEditingController _titleController = TextEditingController();
  TextEditingController _mainController = TextEditingController();

  late String userId;
  late String userEmail;

  @override
  void initState() {
    super.initState();
    selectedColor = bgcolor; // Set default background color
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: selectedColor,
      appBar: AppBar(
        backgroundColor: selectedColor,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          "Create Journal",
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
            onPressed: () async {
              DateTime now = DateTime.now();
              String formattedTimestamp = _formatTimestamp(now);

              FirebaseFirestore.instance
                  .collection("journal")
                  .doc(userId)
                  .collection(userEmail)
                  .add({
                "journal_color":
                    selectedColor.value, // Save selected color value
                "timestamp": now, // Save the DateTime object for ordering
                "formatted_timestamp":
                    formattedTimestamp, // Save the formatted timestamp for display
                "journal_content": _mainController.text,
                "journal_title": _titleController.text,
              }).then((value) {
                Navigator.pop(context);
                PopUpToast.showToast(context, 'Journal added.');
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                _formatTimestamp(DateTime.now()),
                style: AppStyle.mainDate,
              ),
            ),
            const SizedBox(height: 10.0),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Title',
              ),
              style: AppStyle.mainTitle,
            ),
            Container(
              width: double.infinity,
              height: 1,
              margin: EdgeInsets.symmetric(vertical: 8.0),
              child: CustomPaint(
                painter: DottedLinePainter(),
              ),
            ),
            TextField(
              controller: _mainController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Journal Content',
              ),
              style: AppStyle.mainContent,
            ),
          ],
        ),
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    return DateFormat('EEE, dd-MMM-yyyy, h:mm a').format(timestamp);
  }

  void getUser() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      userId = user.uid;
      userEmail = user.email!;
    }
  }
}
