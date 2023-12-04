import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sidekick_app/main.dart';
import 'package:sidekick_app/reusable_widgets/reusable_widget.dart';
import 'package:sidekick_app/routes.dart';
import 'package:sidekick_app/utils/colours.dart';
import 'package:sidekick_app/utils/utils.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _confirmPasswordTextController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  20, MediaQuery.of(context).size.height * 0.2, 20, 0),
              child: Column(children: <Widget>[
                const SizedBox(
                  height: 20,
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
                  height: 20,
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
                reusableFormField(_confirmPasswordTextController, true,
                    Icons.lock_outlined, 'Confirm Password', (value) {
                  if (value!.isEmpty) {
                    return 'Please confirm password';
                  } else if (value != _passwordTextController.text) {
                    return 'Password do not match';
                  } else {
                    return null;
                  }
                }),
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
      ),
    );
  }

  Future signup() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: ((context) =>
            const Center(child: CircularProgressIndicator(color: yellow))));

    try {
      UserCredential? userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _emailTextController.text,
              password: _passwordTextController.text);
      // CALL CREATE USER DOCUMENT FUNCTION
      createUserDocument(userCredential);
    } on FirebaseAuthException catch (e) {
      // ignore: use_build_context_synchronously
      Utils.showSnackBar(context, e.message);
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  // TO ADD USER CREDENTIAL ON FIREBASE FIRESTORE
  Future<void> createUserDocument(UserCredential? userCredential) async {
    if (userCredential != null && userCredential.user != null) {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(userCredential.user!.email)
          .set({
        'email': userCredential.user!.email,
        'user_id': userCredential.user!.uid
      });
    }
  }

  Row loginOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Already Registered?",
            style: TextStyle(color: Colors.black)),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.login);
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
