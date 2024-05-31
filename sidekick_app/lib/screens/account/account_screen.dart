import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sidekick_app/reusable_widgets/reusable_widget.dart';
import 'package:sidekick_app/routes.dart';
import 'package:sidekick_app/screens/account/addfeedback_screen.dart';
import 'package:sidekick_app/utils/sidekick_icons_icons.dart';
import 'package:sidekick_app/utils/colours.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: const BackButton(
          color: black,
        ),
        backgroundColor: bgcolor,
        // elevation: 5,
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.2, 20, 0),
            child: Column(children: <Widget>[
              logoWidget("assets/images/workada_logo.png", 100, 100),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Account",
                style: TextStyle(fontSize: 50),
              ),
              // TO DISPLAY USER EMAIL
              SizedBox(
                height: 40,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                      backgroundColor: const WidgetStatePropertyAll(bgcolorCV),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Icon(
                        SidekickIcons.account,
                        color: black,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        user.email.toString(),
                        style: const TextStyle(color: black, fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // TO DISPLAY ACCOUNT BUTTONS
              accountButton(
                  context, yellow, SidekickIcons.information, 'About Us', () {
                Navigator.pushNamed(context, AppRoutes.aboutus);
              }),
              accountButton(
                  context, yellow, SidekickIcons.feedback, 'Send Feedback', () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const AddFeedback();
                  },
                );
              }),
              accountButton(context, yellow, SidekickIcons.changePassword,
                  'Change Password', () {
                Navigator.pushNamed(context, AppRoutes.forgotPassword);
              }),
              accountButton(context, yellow, SidekickIcons.logout, 'Logout',
                  () {
                FirebaseAuth.instance.signOut().then((value) {
                  Navigator.pushNamed(context, AppRoutes.main);
                });
              }),
              accountButton(context, yellow, SidekickIcons.exit, 'Exit', () {
                SystemNavigator.pop();
              }),
            ]),
          ),
        ),
      ),
    );
  }
}
