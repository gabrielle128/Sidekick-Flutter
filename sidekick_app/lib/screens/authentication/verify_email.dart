import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sidekick_app/navigation_menu.dart';
import 'package:sidekick_app/reusable_widgets/reusable_widget.dart';
import 'package:sidekick_app/utils/colours.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({super.key});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isEmailVerified) {
      sendVerificationEmail();

      timer = Timer.periodic(
        const Duration(seconds: 3),
        (_) => checkEmailVerified(),
      );
    }
  }

  @override
  void dispose() {
    timer?.cancel();

    super.dispose();
  }

  Future checkEmailVerified() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.reload();

      setState(() {
        isEmailVerified = user.emailVerified;
      });

      if (isEmailVerified) timer?.cancel();
    }
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null && mounted) {
        await user.sendEmailVerification();

        setState(() => canResendEmail = false);
        await Future.delayed(const Duration(seconds: 5));
        if (mounted) {
          setState(() => canResendEmail = true);
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
          ),
        );
      }
    }
  }

  Future userSignOut() async {
    if (FirebaseAuth.instance.currentUser != null) {
      await FirebaseAuth.instance.signOut();
    }
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? const NavigationMenu()
      : Scaffold(
          appBar: AppBar(
            backgroundColor: bgcolor,
            elevation: 5,
            title: const Text('Verify Email',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold)),
          ),
          body: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
                child: Padding(
              padding: EdgeInsets.fromLTRB(
                  20, MediaQuery.of(context).size.height * 0.2, 20, 0),
              child: Column(children: <Widget>[
                const Text(
                  "A verification email has been sent to your email.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.normal),
                ),
                const SizedBox(
                  height: 50,
                ),
                loginSignupButton(
                    context, mustard, 'Resend Email', sendVerificationEmail),
                loginSignupButton(context, navy, 'Cancel', userSignOut),
              ]),
            )),
          ),
        );
}
