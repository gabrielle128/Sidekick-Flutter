import 'package:flutter/material.dart';
import 'package:sidekick_app/utils/colours.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
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
              "Wallet Screen",
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
