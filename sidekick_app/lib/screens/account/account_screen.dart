import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sidekick_app/reusable_widgets/reusable_widget.dart';
import 'package:sidekick_app/screens/welcome_screen.dart';
import 'package:sidekick_app/utils/colours.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: const BackButton(
          color: black,
        ),
        backgroundColor: bgcolor,
        elevation: 5,
      ),

      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.2, 20, 0),
            child: Column(children: <Widget>[
              logoWidget("assets/images/sidekick_logo.png"),
              const SizedBox(
                height: 80,
              ),
            ]),
          ),
        ),
      ),

      // body: Center(
      //   child: ElevatedButton(
      //     child: const Text("Logout"),
      //     onPressed: () {
      //       FirebaseAuth.instance.signOut().then((value) {
      //         // ignore: avoid_print
      //         print("Signed Out");
      //         Navigator.push(
      //             context,
      //             MaterialPageRoute(
      //                 builder: (context) => const WelcomeScreen()));
      //       });
      //     },
      //   ),
      // ),
    );
  }
}
