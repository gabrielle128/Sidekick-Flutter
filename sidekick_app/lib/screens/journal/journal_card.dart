import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sidekick_app/screens/journal/delete_journal.dart';
import 'package:sidekick_app/screens/journal/app_style.dart';
import 'package:sidekick_app/screens/journal/edit_journal.dart';

Widget journalCard(
    BuildContext context, Function()? onTap, QueryDocumentSnapshot doc) {
  Color journalColor =
      Color(doc["journal_color"]); // Fetch and convert journal_color to Color
  String formattedDate =
      doc["formatted_timestamp"]; // Get the formatted timestamp

  return InkWell(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.all(15.0),
      margin: const EdgeInsets.symmetric(
          vertical: 4.0, horizontal: 8.0), // Reduced vertical margin
      height: 140, // Set the fixed height here
      decoration: BoxDecoration(
        color: journalColor, // Use fetched journal color here
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color:
                Colors.black.withOpacity(0.2), // Black color with 30% opacity
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(3, 3), // Changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                doc["journal_title"],
                style: AppStyle.mainTitle,
              ),
              PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'edit') {
                    // Navigate to EditJournalScreen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditJournalScreen(doc),
                      ),
                    );
                  } else if (value == 'delete') {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return DeleteJournalDialogue(doc);
                      },
                    );
                  }
                },
                itemBuilder: (BuildContext context) {
                  return {'edit', 'delete'}.map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList();
                },
              ),
            ],
          ),
          const SizedBox(height: 4.0),
          Expanded(
            child: Text(
              doc["journal_content"],
              style: AppStyle.mainContent,
              maxLines: 3, // Limit the number of lines
              overflow: TextOverflow.fade, // Truncate with ellipsis
            ),
          ),
          const SizedBox(height: 8.0),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              formattedDate,
              style: AppStyle.mainDate,
            ),
          ),
        ],
      ),
    ),
  );
}
