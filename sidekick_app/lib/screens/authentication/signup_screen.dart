import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sidekick_app/main.dart';
import 'package:sidekick_app/navigation_menu.dart';
import 'package:sidekick_app/reusable_widgets/reusable_widget.dart';
import 'package:sidekick_app/screens/authentication/login_screen.dart';
import 'package:sidekick_app/utils/colours.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _usernameTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _confirmPasswordTextController =
      TextEditingController();

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
            child: Column(children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              reusableTextField("Username", Icons.person_outline, false,
                  _usernameTextController),
              const SizedBox(
                height: 20,
              ),
              reusableTextField("Email Address", Icons.person_outline, false,
                  _emailTextController),
              const SizedBox(
                height: 20,
              ),
              reusableTextField("Password", Icons.lock_outlined, true,
                  _passwordTextController),
              const SizedBox(
                height: 20,
              ),
              reusableTextField("Confirm Password", Icons.lock_outlined, true,
                  _confirmPasswordTextController),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Please note: with submitting your account registration you confirm that we will process your data according to our privacy policy",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 10,
                    fontWeight: FontWeight.normal),
              ),
              loginSignupButton(context, mustard, 'SIGN UP', signup),
              loginOption()
            ]),
          ),
        ),
      ),
    );
  }

  Future signup() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: ((context) =>
            const Center(child: CircularProgressIndicator(color: yellow))));

    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _emailTextController.text,
              password: _passwordTextController.text)
          .then((value) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const NavigationMenu()));
      });
    } on FirebaseAuthException catch (e) {
      // ignore: avoid_print
      print(e);
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  Row loginOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Already Registered?",
            style: TextStyle(color: Colors.black)),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const LoginScreen()));
          },
          child: const Text(
            " Sign in",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
