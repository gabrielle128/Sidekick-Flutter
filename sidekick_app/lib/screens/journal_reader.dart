import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sidekick_app/style/app_style.dart';

// ignore: must_be_immutable
class JournalReaderScreen extends StatefulWidget {
  JournalReaderScreen(this.doc, {Key? key}) : super(key: key);
  QueryDocumentSnapshot doc;

  @override
  State<JournalReaderScreen> createState() => _JournalReaderScreenState();
}

class _JournalReaderScreenState extends State<JournalReaderScreen> {
  @override
  Widget build(BuildContext context) {
    // ignore: non_constant_identifier_names
    int color_id = widget.doc['color_id'];
    return Scaffold(
      backgroundColor: AppStyle.cardsColor[color_id],
      appBar: AppBar(
        backgroundColor: AppStyle.cardsColor[color_id],
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.doc["journal_title"],
              style: AppStyle.mainTitle,
            ),
            const SizedBox(
              height: 4.0,
            ),
            Text(
              widget.doc["creation_date"],
              style: AppStyle.mainDate,
            ),
            const SizedBox(
              height: 30.0,
            ),
            Text(widget.doc["journal_content"], style: AppStyle.mainContent),
          ],
        ),
      ),
    );
  }
}
