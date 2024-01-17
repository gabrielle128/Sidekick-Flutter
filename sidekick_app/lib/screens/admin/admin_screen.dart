import 'package:flutter/material.dart';
import 'package:sidekick_app/utils/colours.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.fromLTRB(
              20, MediaQuery.of(context).size.height * 0.2, 20, 0),
          child: const Column(children: <Widget>[
            Text(
              "Admin Screen",
              style: TextStyle(color: black, fontSize: 40),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Coming soon...",
              style: TextStyle(color: black, fontSize: 30),
            ),
          ]),
        )),
      ),
    );
  }
}
