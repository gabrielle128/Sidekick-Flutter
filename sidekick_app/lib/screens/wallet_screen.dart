import 'package:flutter/material.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
      child: Text(
        "Wallet Screen",
        style: TextStyle(fontSize: 40),
      ),
    ));
  }
}
