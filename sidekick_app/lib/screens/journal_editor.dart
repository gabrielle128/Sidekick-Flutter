import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sidekick_app/style/app_style.dart';

class JournalEditorScreen extends StatefulWidget {
  JournalEditorScreen({Key? key}) : super(key:key);

  @override
  State<JournalEditorScreen> createState() => _JournalEditorScreenState();

}

class _JournalEditorScreenState extends State<JournalEditorScreen>{
  int color_id = Random().nextInt(AppStyle.cardsColor.length);
  String date = DateTime.now().toString();
  
  TextEditingController _titleController = TextEditingController();
  TextEditingController _mainController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.cardsColor[color_id],
      appBar: AppBar(
        backgroundColor: AppStyle.cardsColor[color_id],
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text("Add new journal", style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Note Title',

              ),
              style: AppStyle.mainTitle,
            ),
            SizedBox(height: 18.0,),
            Text(date, style:AppStyle.mainDate,),
            SizedBox(height: 28.0),

            TextField(
              controller: _mainController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Journal Content',
              ),
              style: AppStyle.mainContent,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          FirebaseFirestore.instance.collection("journal").add({
            "color_id" : color_id, 
            "creation_date" : date,  
            "journal_content" : _mainController.text, 
            "journal_title" : _titleController.text,
          }).then((value){
            Navigator.pop(context);
          });
        },
        child: Icon(Icons.save),
      ),
    );
  }
}