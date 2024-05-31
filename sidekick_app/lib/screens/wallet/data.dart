import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sidekick_app/utils/colours.dart';

List<Map<String, dynamic>> walletData = [
  {
    'icon': Icon(
      Icons.food_bank,
      color: white,
    ),
    'color': yellow,
    'name': 'Food',
    'totalAmount': '-₱ 100.00',
    'date': 'Today',
  },
  {
    'icon': Icon(
      Icons.shopping_bag,
      color: white,
    ),
    'color': purple,
    'name': 'Shopping',
    'totalAmount': '-₱ 2000.00',
    'date': 'Today',
  },
  {
    'icon': Icon(
      Icons.health_and_safety,
      color: white,
    ),
    'color': blue,
    'name': 'Health',
    'totalAmount': '-₱ 500.00',
    'date': 'Yesterday',
  },
  {
    'icon': Icon(
      Icons.wallet_travel,
      color: white,
    ),
    'color': green,
    'name': 'Travel',
    'totalAmount': '-₱ 1000.00',
    'date': 'Yesterday',
  },
];
