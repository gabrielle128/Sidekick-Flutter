import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sidekick_app/main.dart';
import 'package:sidekick_app/reusable_widgets/reusable_widget.dart';
import 'package:sidekick_app/routes.dart';
import 'package:sidekick_app/utils/colours.dart';
import 'package:sidekick_app/utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();

  @override
  void dispose() {
    _emailTextController.dispose();
    _passwordTextController.dispose();

    super.dispose();
  }

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
            const Text(
              "Workada",
              style: TextStyle(color: black, fontSize: 50),
            ),
            const SizedBox(
              height: 50,
            ),
            reusableFormField(
                _emailTextController,
                false,
                Icons.person_outline,
                'Email Address',
                (email) => email != null && !EmailValidator.validate(email)
                    ? 'Enter a valid email'
                    : null),
            const SizedBox(
              height: 30,
            ),
            reusableFormField(
                _passwordTextController,
                true,
                Icons.lock_outlined,
                'Password',
                (value) => value != null && value.length < 6
                    ? 'Enter mininum of 6 characters'
                    : null),
            const SizedBox(
              height: 20,
            ),
            loginSignupButton(context, mustard, 'LOG IN', login),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.forgotPassword);
              },
              child: const Text("Forgot Password?",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(
              height: 50,
            ),
            loginSignupButton(context, navy, 'CREATE', () {
              Navigator.pushNamed(context, AppRoutes.signup);
            }),
          ]),
        )),
      ),
    );
  }

  Future login() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: ((context) =>
            const Center(child: CircularProgressIndicator(color: yellow))));

    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _emailTextController.text,
              password: _passwordTextController.text)
          .then((value) {
        Navigator.pushNamed(context, AppRoutes.navigation);
      });
    } on FirebaseAuthException catch (e) {
      // ignore: avoid_print
      print(e);

      // ignore: use_build_context_synchronously
      Utils.showSnackBar(context, e.message);
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
