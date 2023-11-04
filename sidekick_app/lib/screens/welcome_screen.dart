import 'package:flutter/material.dart';
import 'package:sidekick_app/reusable_widgets/reusable_widget.dart';
import 'package:sidekick_app/screens/login_screen.dart';
import 'package:sidekick_app/screens/signup_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        // decoration: BoxDecoration(
        //     gradient: LinearGradient(colors: [
        //   hexStringToColor("CB2B93"),
        //   hexStringToColor("9546C4"),
        //   hexStringToColor("5E61F4")
        // ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.2, 20, 0),
            child: Column(children: <Widget>[
              logoWidget("assets/images/sidekick_logo.png"),
              const SizedBox(
                height: 80,
              ),
              loginSignupButton(context, true, () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()));
              }),
              loginSignupButton(context, false, () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignUpScreen()));
              }),
            ]),
          ),
        ),
      ),
    );
  }
}