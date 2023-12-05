//import 'dart:html';

import 'package:flutter/material.dart';
//import 'package:sidekick_app/sidekick_icons_icons.dart';
//import 'package:sidekick_app/utils/colours.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:sidekick_app/reusable_widgets/journal_card.dart';
import 'package:sidekick_app/screens/journal_reader.dart';
import 'package:sidekick_app/screens/journal_editor.dart';


class JournalScreen extends StatefulWidget {
  const JournalScreen({super.key});

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Journal Jonas"),
        centerTitle: true,
        backgroundColor: Colors.black26,
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment:  MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Your Journal", 
              style: GoogleFonts.roboto(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 22 ),
              ),

            const SizedBox(
              height: 20.0,
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection("journal").snapshots(),
                builder: (context, AsyncSnapshot <QuerySnapshot> snapshot) {
            
                  if (snapshot.connectionState == ConnectionState.waiting){
                    return Center (
                      child: CircularProgressIndicator(),
                    );
                    
                  }
            
                  if (snapshot.hasData){
                    return GridView(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                      children: snapshot.data!.docs
                      .map((journal) => journalCard(() {
                        Navigator.push(
                          context, 
                          MaterialPageRoute(
                            builder: (context) => 
                            JournalReaderScreen(journal),));
                      }, journal)).toList(),
                    );
            
                }
                return Text("Empty List of Journal", style: GoogleFonts.nunito(color: Colors.black87),);
                },
              ),
            )
          ],
      ) 
    ),
    floatingActionButton: FloatingActionButton.extended(
      onPressed: () {
        Navigator.push(context, 
        MaterialPageRoute(builder: (context) => JournalEditorScreen()));
      },
      label: Text("Add Journal"),
      icon: Icon(Icons.add),
      
    ),
    );
  }
}
