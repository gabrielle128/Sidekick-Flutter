import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sidekick_app/utils/sidekick_icons_icons.dart';
import 'package:sidekick_app/utils/colours.dart';
import 'package:intl/intl.dart';

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
        foregroundColor: Colors.black,
        title: Text("Feedbacks", style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: yellow,
      ),
      body: FutureBuilder(
        future: getFeedbacksFromFirestore(),
        builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No feedbacks found"));
          } else {
            return ListView.builder(
              padding: EdgeInsets.only(top: 16),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var feedbackData = snapshot.data![index];
                return GestureDetector(
                  onTap: () => _showFeedbackDialog(context, feedbackData),
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    SidekickIcons.account,
                                    size: 30,
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      feedbackData['userEmail'],
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(
                                    SidekickIcons.feedback,
                                    size: 30,
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      feedbackData['feedback'],
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                            width:
                                10), // Add some spacing between text and delete icon
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: Icon(Icons.delete, color: red),
                              onPressed: () => _confirmDeleteFeedback(
                                  context, feedbackData['id']),
                            ),
                            Text(
                              _formatTimestamp(feedbackData['timestamp']),
                              style:
                                  TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Future<List<Map<String, dynamic>>> getFeedbacksFromFirestore() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance.collection('feedbacks').get();

    return querySnapshot.docs.map((doc) {
      return {
        'id': doc.id,
        'userEmail': doc['userEmail'],
        'feedback': doc['feedback'],
        'timestamp':
            doc['timestamp'] != null ? doc['timestamp'].toDate() : null,
      };
    }).toList();
  }

  String _formatTimestamp(DateTime? timestamp) {
    if (timestamp == null) return '';
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(timestamp);
  }

  void _showFeedbackDialog(
      BuildContext context, Map<String, dynamic> feedbackData) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Feedback"),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("User Email: ${feedbackData['userEmail']}"),
              SizedBox(height: 20),
              Text("Feedback:"),
              SizedBox(height: 5),
              Text(feedbackData['feedback']),
              SizedBox(height: 10),
              Text(
                "Timestamp: ${_formatTimestamp(feedbackData['timestamp'])}",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _confirmDeleteFeedback(BuildContext context, String feedbackId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete Feedback"),
          content: Text("Do you want to delete this feedback?"),
          actions: <Widget>[
            TextButton(
              child: Text("No"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Yes"),
              onPressed: () async {
                await _deleteFeedback(feedbackId);
                Navigator.of(context).pop();
                setState(() {}); // Refresh the feedback list
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteFeedback(String feedbackId) async {
    await FirebaseFirestore.instance
        .collection('feedbacks')
        .doc(feedbackId)
        .delete();
  }
}
