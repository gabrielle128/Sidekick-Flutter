import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sidekick_app/utils/sidekick_icons_icons.dart';
import 'package:sidekick_app/utils/colours.dart'; // Import Firestore

class UsersScreen extends StatefulWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          foregroundColor: Colors.black,
          title: Text("Users", style: TextStyle(color: Colors.black)),
          centerTitle: true,
          backgroundColor: yellow),
      body: FutureBuilder(
        future: getUsersFromFirestore(), // Replace with your Firestore call
        builder: (context, AsyncSnapshot<List<String>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Text("No users found");
          } else {
            return ListView.builder(
              padding: EdgeInsets.only(
                  top: 16), // Add space above the first user rectangle
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Add account icon on the left
                      Icon(
                        SidekickIcons.account,
                        size: 30, // Customize icon color as needed
                      ),
                      SizedBox(
                          width: 20), // Add some spacing between icon and text
                      // User email in the center
                      Center(
                        child: Text(snapshot.data![index]),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Future<List<String>> getUsersFromFirestore() async {
    // Replace this with your Firestore query to get user emails
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance.collection('users').get();

    // Extract user emails from the query result
    List<String> userEmails = querySnapshot.docs
        .map((DocumentSnapshot<Map<String, dynamic>> doc) {
          return doc.get('email') as String;
        })
        .where((email) => email != null && email.isNotEmpty)
        .toList();

    return userEmails;
  }
}
